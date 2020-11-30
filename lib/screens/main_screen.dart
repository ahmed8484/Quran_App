import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_listienning/bloc/main/main_screen_bloc.dart';
import 'package:quran_listienning/data/models/ayah.dart';
import 'package:quran_listienning/data/models/azkar.dart';
import 'package:quran_listienning/data/models/quran_data.dart';
import 'package:quran_listienning/data/repo.dart';
import 'package:quran_listienning/data/sheikh.dart';
import 'package:quran_listienning/screens/listen.dart';
import 'package:quran_listienning/widgets/mood_ui.dart';
import 'package:quran_listienning/widgets/play_list_ui.dart';
import 'package:quran_listienning/widgets/sheikh_container.dart';

import '../searchBar.dart';
import 'choose_sura.dart';

class MyHomePage extends StatelessWidget {
  Widget appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ),
        Expanded(
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'Search',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: DataSearch(DataRepo().items));
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                25,
              ),
            ),
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 50,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                    'http://3.bp.blogspot.com/-zy5M-E-npPI/VHVPboV784I/AAAAAAAACu0/o4-nzUappSQ/s1600/sarah%2Bvaughan.png'),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildMood() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 20, top: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              'My mood',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Container(
            width: double.infinity,
            height: 50,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    MoodUi(
                      imageNumber: index + 1,
                    ),
                    SizedBox(
                      width: 24,
                    )
                  ],
                );
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
            ),
          ),
        )
      ],
    );
  }

  Widget quranBuild(List<Sheikh> items, List<Ayah> ayaItems) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ShikhContainer(
                    title: items[index].name,
                    imageUrl: items[index].imageUrl,
                    id: items[index].id,
                    onTap: toNavigat);
              },
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              'PLAY LISTS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: playList(ayaItems),
          )
        ],
      ),
    );
  }

  Widget playList(List<Ayah> ayaItems) {
    final List<Data> ayaItemsData = ayaItems
        .map(
          (e) => Data(
              link: e.ayaUrl,
              sora: e.aya,
              id: e.ayahNumper.toString(),
              readerName: 'مشاري'),
        )
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return PlayListUi(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (
                  context,
                ) =>
                    Listen(ayaItemsData, 1, index),
              ),
            );
          },
          title: ayaItems[index].aya,
          ayahNumber: ayaItems[index].ayahNumper,
        );
      },
      itemCount: ayaItems.length,
    );
  }

  Widget azkarBuild(AzkarData azkarData) {
    return Expanded(
      child: ListView.builder(
          itemCount: azkarData.items.length,
          itemBuilder: (context, i) => Container(
                margin: EdgeInsets.all(15),
                height: 300,
                child: GestureDetector(
                  onTap: () {
                    final List<Data> dataAzkar = azkarData.items
                        .map(
                          (e) => Data(
                              link: azkarData.items[i].link,
                              readerName: azkarData.items[i].readerName,
                              sora: azkarData.items[i].name,
                              id: '1'),
                        )
                        .toList();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Listen(dataAzkar, 1, i),
                      ),
                    );
                  },
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: Image.network(
                            DataRepo().items[i].imageUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 260,
                        right: 0,
                        top: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              azkarData.items[i].name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }

  onTap(int i, BuildContext context) {
    if (i == 0) {
      BlocProvider.of<MainScreenBloc>(context).add(ChangeToQuran());
    }
    if (i == 1) {
      BlocProvider.of<MainScreenBloc>(context).add(ChangeToAzkar());
    }
  }

  toNavigat(int id, BuildContext context) {
    BlocProvider.of<MainScreenBloc>(context).add(NavigteTo(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2F2),
      body: SafeArea(
        child: Column(
          children: [
            appBar(context),
            buildMood(),
            SizedBox(
              height: 24,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      40,
                    ),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        initialIndex: 0,
                        length: 2,
                        child: TabBar(
                          indicatorColor: Colors.pinkAccent[100],
                          labelColor: Colors.pinkAccent[100],
                          indicatorWeight: 0.5,
                          unselectedLabelColor: Colors.grey[400],
                          // controller: DefaultTabController(),
                          onTap: (i) {
                            onTap(i, context);
                          },
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'َقــران',
                              ),
                            ),
                            Text(
                              'أذكار',
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocConsumer<MainScreenBloc, MainScreenState>(
                        listener: (ctx, state) {
                      if (state is NavigateToGetData) {
                        print('object1');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return ChooseSura(
                                id: state.id,
                              );
                            },
                          ),
                        );
                      }
                    }, builder: (context, state) {
                      if (state is MainScreenInitial) {
                        onTap(0, context);
                        return Center(child: CircularProgressIndicator());
                      } else if (state is MainScreenLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is MainScreenAzkar) {
                        return azkarBuild(state.azkarData);
                      } else if (state is MainScreenQuran) {
                        return quranBuild(state.items, state.ayaItems);
                      } else if (state is MainScreenError) {
                        return Center(
                          child: Text('error'),
                        );
                      } else {
                        onTap(0, context);
                        return Container();
                      }
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}