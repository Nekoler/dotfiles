const ActivePane = Zotero.getActiveZoteroPane();
const items = ZoteroPane.getSelectedItems();
const regex = /\p{Script=Han}/u;
const update = [];
let log = 'log';
for (const item of items) {
    if (!item.isRegularItem()) {
        continue;
    }
    let save = false;
    const key = item.getField('key');
    const lang = item.getField('language');
    const rights = item.getField('rights');
    const title = item.getField('title');
    if (rights != key) {
        item.setField('rights', key);
        save = true;
    }
    let test = regex.test(title);
    if (test && lang != 'zh') {
        item.setField('language', 'zh');
        save = true;
    } else if (!test && lang != 'en') {
        item.setField('language', 'en');
        save = true;
    }
    if (save) {
        update.push(item.saveTx());
        log += `\n${title}`;
    }
}
await Promise.all(update);
return log;
