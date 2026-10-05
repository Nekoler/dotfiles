ActivePane = Zotero.getActiveZoteroPane();
items = ZoteroPane.getSelectedItems();
var update = [];
var log = 'Start';
var field = 'rights';
for (item of items) {
    key = item.getField('key');
    value = item.getField(field);
    if (value != key) {
        item.setField(field, key);
        update.push(item.saveTx());
        log += `\n${item.getField('title')}`;
    }
}
await Promise.all(update);
return log;
