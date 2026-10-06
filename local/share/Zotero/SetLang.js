ActivePane = Zotero.getActiveZoteroPane();
items = ZoteroPane.getSelectedItems();
var update = [];
var log = 'Start';
var target = 'zh';
var field = 'language';
for (item of items) {
    lang = item.getField(field);
    if (lang != target) {
        item.setField(field, target);
        update.push(item.saveTx());
        log += `\n${item.getField('title')}`;
    }
}
await Promise.all(update);
return log;
