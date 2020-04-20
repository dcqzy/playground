class RowItem {
  dynamic data;
  String identify;
  bool arrow;
  bool selected;
  bool fixed;
  double height;
  bool editing;
  String title;
  String subTitle;
  int id;

  RowItem(
      {this.data,
      this.identify,
      this.arrow = true,
      this.selected = false,
      this.fixed = false,
      this.height,
      this.editing = false,
      this.title,
      this.subTitle,
      this.id});
}
