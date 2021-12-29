import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_model.dart';
import 'package:news_app/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  const NewsList({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(newTaken: news[index], index: index);
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article newTaken;
  final int index;
  const _New({Key? key, required this.index, required this.newTaken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(newTaken: newTaken, index: index),
        _TitleCard(newTaken: newTaken),
        _ImageCard(newTaken: newTaken),
        _BodyCard(newTaken: newTaken),
        _ButtonsCard(newTaken: newTaken),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article newTaken;

  const _BodyCard({
    Key? key,
    required this.newTaken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        (newTaken.description != null) ? newTaken.description! : '',
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  final Article newTaken;

  const _ButtonsCard({
    Key? key,
    required this.newTaken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.star_border)),
        const SizedBox(width: 10),
        RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.more_horiz)),
      ],
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article newTaken;

  const _ImageCard({
    Key? key,
    required this.newTaken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: (newTaken.urlToImage != null)
                ? FadeInImage(
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage('assets/no-image.png'),
                      );
                    },
                    placeholder: const AssetImage('assets/giphy.gif'),
                    image: NetworkImage(newTaken.urlToImage!))
                : const Image(
                    image: AssetImage('assets/no-image.png'),
                  )),
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article newTaken;

  const _TitleCard({
    Key? key,
    required this.newTaken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        newTaken.title!,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article newTaken;
  final int index;

  const _TopBarCard({
    Key? key,
    required this.newTaken,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: myTheme.primaryColor)),
          Text('${newTaken.source!.name}. '),
        ],
      ),
    );
  }
}
