import 'package:flutter/material.dart';
import 'package:mine_sweeper_game/ui/theme/colors.dart';
import 'package:mine_sweeper_game/utils/game_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MineSweeperGame game = MineSweeperGame();

  @override
  void initState() {
    super.initState();
    game.generateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text("MineSweeper"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.lightPrimaryColor,
                    borderRadius: BorderRadiusDirectional.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.flag,
                        color: AppColor.accentColor,
                        size: 34,
                      ),
                      Text("10",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.lightPrimaryColor,
                    borderRadius: BorderRadiusDirectional.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.timer,
                        color: AppColor.accentColor,
                        size: 34,
                      ),
                      Text("10:32",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ))
              ],
            ),
            Container(
              width: double.infinity,
              height: 500,
              margin: EdgeInsets.all(20),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MineSweeperGame.row,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: MineSweeperGame.cell,
                  itemBuilder: (context, index) {
                    Color cellColor = game.gameMap[index].reveal
                        ? AppColor.clickedColor
                        : AppColor.lightPrimaryColor;
                    return GestureDetector(
                      onTap: game.gameOver
                          ? null
                          : () {
                              setState(() {
                                game.getClickedCell(game.gameMap[index]);
                              });
                            },
                      child: Container(
                        decoration: BoxDecoration(
                            color: cellColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                            child: Text(
                          game.gameMap[index].reveal
                              ? "${game.gameMap[index].content}"
                              : "",
                          style: TextStyle(
                              color: game.gameMap[index].reveal
                                  ? game.gameMap[index].content == "X"
                                      ? Colors.red
                                      : AppColor.letterColors[
                                          game.gameMap[index].content]
                                  : Colors.transparent,
                              fontSize: 20),
                        )),
                      ),
                    );
                  }),
            ),
            Text(
              game.gameOver ? "You Loose" : "",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 20,
            ),
            RawMaterialButton(
              onPressed: () {
                setState(() {
                  game.resetGame();
                  game.gameOver = false;
                });
              },
              fillColor: AppColor.lightPrimaryColor,
              elevation: 0,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 64, vertical: 18),
              child: Text(
                "Repeat",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
