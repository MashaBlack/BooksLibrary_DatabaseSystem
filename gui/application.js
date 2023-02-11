function Books() {
    var text = '<tr><th>Title</th><th>Publishing Year</th><th>Genre</th><th>Cover Type</th><th>Publishing House</th><th>Authors</th><th>ISBN</th></tr>';
    var fields = ['Title', 'Year', 'Genre', 'CoverType', 'PublishingHouse', 'Authors', 'Isbn'];
    ShowForm('Books Library', 'books', text, '../interface/allBooks.jsp', 'Book', fields);
}

function ShowForm(header_text, table_class, table_header, page_jsp, delete_func_name, fields) {
    header = document.createElement('h1');
    header.innerHTML = header_text;
    table = document.createElement('table');
    table.setAttribute('class', table_class);
    table.innerHTML = table_header;
    var c = document.getElementById('container');
    c.innerHTML = '';
    c.appendChild(header);
    c.appendChild(table);
    var xhr = new XMLHttpRequest();
    xhr.open('GET', page_jsp);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            var resp = xhr.responseText;
            var myObject = eval('(' + resp + ')');
            myObject.forEach(value => {
                row = document.createElement('tr');
                row.innerHTML = AddRow(value, fields);
                edit = document.createElement('td');
                edit.innerHTML = '<a href="javascript:delete' + delete_func_name + '(' + value.ID + ')">Delete</a>';
                row.appendChild(edit);
                table.firstChild.appendChild(row);
            });
        }
    }
    xhr.send();
}

function AddRow(value, fields) {
    var res = "";
    for (let i = 0; i < fields.length; i++) {
        if (fields[i] == 'Books') {
            var books = value[fields[i]];
            if (books == undefined) {
                books = "";
            }
            res += '<th>' + books + '</th>';
        } else {
            res += '<th>' + value[fields[i]] + '</th>';
        }
    }
    return res;
}

function Authors() {
    var text = '<tr><th>Name</th><th>Books in Library</th></tr>';
    var fields = ['Author', 'Books'];
    ShowForm('Authors', 'authors', text, '../interface/allAuthors.jsp', 'Author', fields);
}

function PublHouses() {
    var text = '<tr><th>Publishing House Name</th><th>Phone Number</th><th>Email</th><th>Books in Library</th></tr>';
    var fields = ['Name', 'Phone', 'Email', 'Books'];
    ShowForm('Publishing Houses', 'publhouses', text, '../interface/allPublHouses.jsp', 'PublHouse', fields);
}

function deleteBook(id) {
    Delete('book', 'bookID=', '../interface/deleteBook.jsp', Books, id);
}

function deleteAuthor(id) {
    Delete('author', 'authorID=', '../interface/deleteAuthor.jsp', Authors, id);
}

function deletePublHouse(id) {
    Delete('publishing house', 'publHouseID=', '../interface/deletePublHouse.jsp', PublHouses, id);
}

function Delete(confirm_text, param, jsp_page, nex_func, id) {
    if (confirm("Do you really want to delete this " + confirm_text + "?")) {
        var xhr = new XMLHttpRequest();
        var body = param + encodeURIComponent(id);
        xhr.open('POST', jsp_page);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4) {
                nex_func();
            }
        }
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.send(body);
    }
}

function addBook() {
    CreateForm('Book', 'add_book')
    CreateTextInput("Title", "book_title", "table_add_book");
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '../interface/book_info.jsp');
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            var resp = xhr.responseText;
            var myObject = eval('(' + resp + ')');
            CreateSelectInput("genre", "Genre", myObject.genre, "genre_id", "genre_name", "table_add_book");
            CreateTextInput("Publishing Year", "publish_year", "table_add_book");
            CreateSelectInput("publish_house", "Publishing House", myObject.publishing_house, "publ_house_id", "publ_house_name", "table_add_book");
            CreateTextInput("ISBN", "ISBN", "table_add_book");
            CreateSelectInput("cover", "Cover Type", myObject.cover, "cover_id", "cover_type", "table_add_book");
            CreateFormButton('button_add_book', 'add_book_button()', 'table_add_book');
            SelectorAdd("Author", myObject.author, "author_id", "author_name", "table_add_book", "+", 'newSelector()');

        }
    }
    xhr.send();
}

function SelectorAdd(header, val, id, name, table, add_remove, click) {
    var form = document.getElementById(table);
    var line = document.createElement('tr');
    var row1 = document.createElement('td');
    row1.innerHTML = header;
    line.appendChild(row1);
    var row2 = document.createElement('td');
    var elem = document.createElement('select');
    elem.setAttribute('class', 'authors');
    var res = "";
    val.forEach(value => {
        res += "<option value=" + value[id] + ">" + value[name] + "</option>";
    });
    var row3 = document.createElement('td');
    var button_add = document.createElement('input');
    button_add.setAttribute('type', 'button');
    button_add.setAttribute('value', add_remove);
    button_add.setAttribute('onClick', click);
    elem.innerHTML = res;
    row2.appendChild(elem);
    row3.appendChild(button_add);
    line.appendChild(row2);
    line.appendChild(row3);
    tr = document.getElementsByTagName('tr');
    tr1 = tr[tr.length - 1];
    tr1.before(line);

}

function newSelector() {
    var elem = document.getElementsByClassName('authors');
    var indx = elem.length;;
    var str = "";
    for (let i = 1; i < indx + 1; i++) {
        if (i != indx) {
            str += "author" + i + "=" + encodeURIComponent(elem[i - 1].value) + "&";
        } else {
            str += "count=" + indx + "&author" + i + "=" + encodeURIComponent(elem[i - 1].value);
        }
    }
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '../interface/freeAuthor.jsp');
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            var resp = xhr.responseText;
            var myObject = eval('(' + resp + ')');
            SelectorAdd("Author", myObject.author, "author_id", "author_name", "table_add_book", "-", 'delSelector(this.parentNode.parentNode.rowIndex)');
            for (let i = 0; i < indx; i++) {
                elem[i].setAttribute("disabled", true);
            }
        }
    }
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send(str);

}

function delSelector(idx) {
    var count = document.getElementsByClassName('authors').length;
    var elems = document.getElementsByTagName('tr');
    var authors = document.getElementsByClassName('authors');
    var count1 = elems.length;
    var table = document.getElementById('table_add_book');
    var sel = elems[idx];
    if (idx == count1 - 2) {
        id = count - 2;
        authors[id].disabled = false;
    }
    table.removeChild(sel);
}

function addAuthor() {
    CreateForm('Author', 'add_author');
    CreateTextInput("First Name", "first_name", "table_add_author", "30");
    CreateTextInput("Second Name", "second_name", "table_add_author", "40");
    CreateTextInput("Patronymic", "patr", "table_add_author", "30");
    CreateFormButton('button_add_author', 'add_author_button()', 'table_add_author');
}

function addGenre() {
    CreateForm('Genre', 'add_genre');
    CreateTextInput("Genre Name", "genre_name", "table_add_genre", "30");
    CreateFormButton('button_add_genre', 'add_genre_button()', 'table_add_genre');
}

function addPublHouse() {
    CreateForm('Publishing House', 'add_publ_house');
    CreateTextInput("Publishing Name", "publ_name", "table_add_publ_house", "40");
    CreateTextInput("Phone", "publ_phone", "table_add_publ_house", "25");
    CreateTextInput("Email", "publ_email", "table_add_publ_house", "30");
    CreateFormButton('button_add_publ_house', 'add_publ_house_button()', 'table_add_publ_house');
}

function add_book_button() {
    var authors = document.getElementsByClassName('authors');
    count = authors.length;
    res = "&count=" + count;
    for (let i = 0; i < count; i++) {
        id = i + 1;
        res += "&author" + id + "=" + encodeURIComponent(authors[i].value);
    }
    var xhr = new XMLHttpRequest();
    var body = "title=" + encodeURIComponent(document.getElementById("book_title").value) + "&genre=" + encodeURIComponent(document.getElementById("genre").value) + "&year=" + encodeURIComponent(document.getElementById("publish_year").value) +
        "&house=" + encodeURIComponent(document.getElementById("publish_house").value) + "&ISBN=" + encodeURIComponent(document.getElementById("ISBN").value) + "&cover=" + encodeURIComponent(document.getElementById("cover").value) + res;
    xhr.open('POST', '../interface/addBook.jsp');
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            Books();
        }
    }
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send(body);
}

function add_author_button() {
    var xhr = new XMLHttpRequest();
    var body = "FN=" + encodeURIComponent(document.getElementById("first_name").value) + "&SN=" + encodeURIComponent(document.getElementById("second_name").value) + "&P=" + encodeURIComponent(document.getElementById("patr").value);
    xhr.open('POST', '../interface/addAuthor.jsp');
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            Authors();
        }
    }
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send(body);
}

function add_genre_button() {
    var xhr = new XMLHttpRequest();
    var body = "genre=" + encodeURIComponent(document.getElementById("genre_name").value);
    xhr.open('POST', 'interface/addGenre.jsp');
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            alert("You have just added new genre");
        }
    }
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send(body);
}

function add_publ_house_button() {
    var xhr = new XMLHttpRequest();
    var body = "name=" + encodeURIComponent(document.getElementById("publ_name").value) + "&email=" + encodeURIComponent(document.getElementById("publ_email").value) + "&phone=" + encodeURIComponent(document.getElementById("publ_phone").value);
    xhr.open('POST', '../interface/addPublishingHouse.jsp');
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            PublHouses();
        }
    }
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send(body);
}

function CreateForm(header_name, form_id) {
    var main = document.getElementById("container");
    main.innerHTML = "";
    var header = document.createElement('h1');
    header.innerHTML = "Add " + header_name;
    main.appendChild(header);
    var form = document.createElement('form');
    table = document.createElement('table');
    form.setAttribute('method', 'POST');
    form.setAttribute('id', 'form_' + form_id);
    table.setAttribute('id', 'table_' + form_id);
    main.appendChild(form);
    form.appendChild(table);
}

function CreateTextInput(p_text, input_id, table, size) {
    var table = document.getElementById(table);
    var line = document.createElement('tr');
    var row1 = document.createElement('td');
    row1.innerHTML = p_text;
    line.appendChild(row1);
    var row2 = document.createElement('td');
    var input = document.createElement('input');
    input.setAttribute('id', input_id);
    input.setAttribute('type', 'text');
    input.setAttribute('size', size);
    row2.appendChild(input);
    line.appendChild(row2);
    table.appendChild(line);
}

function CreateSelectInput(select_id, p_text, val, id, name, table) {
    var form = document.getElementById(table);
    var line = document.createElement('tr');
    var row1 = document.createElement('td');
    row1.innerHTML = p_text;
    line.appendChild(row1);
    var row2 = document.createElement('td');
    var elem = document.createElement('select');
    elem.setAttribute('id', select_id);
    var res = "";
    val.forEach(value => {
        res += "<option value=" + value[id] + ">" + value[name] + "</option>";
    });
    elem.innerHTML = res;
    row2.appendChild(elem);
    line.appendChild(row2);
    form.appendChild(line);
}

function CreateFormButton(button_id, on_click, form_id) {
    var line = document.createElement('tr');
    var button_add = document.createElement('input');
    button_add.setAttribute('id', button_id);
    button_add.setAttribute('type', 'button');
    button_add.setAttribute('class', 'button_add');
    button_add.setAttribute('value', 'Add');
    button_add.setAttribute('onClick', on_click);
    line.appendChild(button_add);
    var form = document.getElementById(form_id);
    form.appendChild(line);
}