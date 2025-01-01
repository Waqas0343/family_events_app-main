class NoticeboardItem {
  String id;
  String name;
  String type; // 'event' or 'task'

  NoticeboardItem({
    required this.id,
    required this.name,
    required this.type,
  });
}