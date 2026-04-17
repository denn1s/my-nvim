# Emmet Tutorial - From Zero to Hero

Emmet is like a superpower for writing HTML/CSS. Instead of typing out full tags, you write abbreviations and expand them.

**How to expand in Neovim**: Type your abbreviation, then press `<C-y>,` (Ctrl+e, then comma)

---

## 🎯 Part 1: The Basics

### 1. HTML Boilerplate
The fastest way to start any HTML file:

**Type this**: `!`
**Press**: `<C-y>,`
**You get**:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

</body>
</html>
```

**✏️ Try it now**: Create a new file called `test.html` and type `!` then `<C-y>,`

---

### 2. Single Tags

**Type**: `div` → `<C-y>,`
**Result**: `<div></div>`

**Type**: `p` → `<C-y>,`
**Result**: `<p></p>`

**Type**: `h1` → `<C-y>,`
**Result**: `<h1></h1>`

**Type**: `img` → `<C-y>,`
**Result**: `<img src="" alt="">`

**Type**: `input` → `<C-y>,`
**Result**: `<input type="text">`

---

### 3. Classes and IDs

#### Classes (use `.`)
**Type**: `div.container` → `<C-y>,`
**Result**: `<div class="container"></div>`

**Type**: `p.intro` → `<C-y>,`
**Result**: `<p class="intro"></p>`

**Type**: `div.header.main` → `<C-y>,`
**Result**: `<div class="header main"></div>` (multiple classes!)

**Shorthand**: `.container` → `<C-y>,`
**Result**: `<div class="container"></div>` (div is implied!)

#### IDs (use `#`)
**Type**: `div#header` → `<C-y>,`
**Result**: `<div id="header"></div>`

**Type**: `#main` → `<C-y>,`
**Result**: `<div id="main"></div>`

#### Combining Classes and IDs
**Type**: `div#header.container.main` → `<C-y>,`
**Result**: `<div id="header" class="container main"></div>`

**✏️ Try it**:
- `div.card`
- `section#about`
- `.btn.primary`
- `#hero.full-width.bg-dark`

---

## 🚀 Part 2: Nesting and Siblings

### 4. Child Elements (use `>`)

**Type**: `div>p` → `<C-y>,`
**Result**:
```html
<div>
    <p></p>
</div>
```

**Type**: `ul>li` → `<C-y>,`
**Result**:
```html
<ul>
    <li></li>
</ul>
```

**Type**: `nav>ul>li>a` → `<C-y>,`
**Result**:
```html
<nav>
    <ul>
        <li><a href=""></a></li>
    </ul>
</nav>
```

### 5. Sibling Elements (use `+`)

**Type**: `h1+p` → `<C-y>,`
**Result**:
```html
<h1></h1>
<p></p>
```

**Type**: `header+main+footer` → `<C-y>,`
**Result**:
```html
<header></header>
<main></main>
<footer></footer>
```

### 6. Combining Children and Siblings

**Type**: `div>h1+p` → `<C-y>,`
**Result**:
```html
<div>
    <h1></h1>
    <p></p>
</div>
```

**Type**: `header>nav>ul>li+li+li` → `<C-y>,`
**Result**:
```html
<header>
    <nav>
        <ul>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </nav>
</header>
```

**✏️ Try it**:
- `section>h2+p+p`
- `div>header+main+footer`
- `nav>ul>li>a`

---

## 🎨 Part 3: Multiplication and Power Features

### 7. Multiply Elements (use `*`)

**Type**: `li*3` → `<C-y>,`
**Result**:
```html
<li></li>
<li></li>
<li></li>
```

**Type**: `ul>li*5` → `<C-y>,`
**Result**:
```html
<ul>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
</ul>
```

**Type**: `div.card*3` → `<C-y>,`
**Result**:
```html
<div class="card"></div>
<div class="card"></div>
<div class="card"></div>
```

### 8. Numbering (use `$`)

**Type**: `ul>li.item$*3` → `<C-y>,`
**Result**:
```html
<ul>
    <li class="item1"></li>
    <li class="item2"></li>
    <li class="item3"></li>
</ul>
```

**Type**: `h2{Section $}*3` → `<C-y>,`
**Result**:
```html
<h2>Section 1</h2>
<h2>Section 2</h2>
<h2>Section 3</h2>
```

**Type**: `div#section$*3` → `<C-y>,`
**Result**:
```html
<div id="section1"></div>
<div id="section2"></div>
<div id="section3"></div>
```

**Padding**: `ul>li.item$$$*3` → `<C-y>,`
**Result**:
```html
<ul>
    <li class="item001"></li>
    <li class="item002"></li>
    <li class="item003"></li>
</ul>
```

**✏️ Try it**:
- `div.col$*4`
- `img[src="image$.jpg"]*3`

---

### 9. Grouping (use `()`)

**Type**: `div>(header>h1)+main+footer` → `<C-y>,`
**Result**:
```html
<div>
    <header>
        <h1></h1>
    </header>
    <main></main>
    <footer></footer>
</div>
```

**Type**: `ul>(li>a)*3` → `<C-y>,`
**Result**:
```html
<ul>
    <li><a href=""></a></li>
    <li><a href=""></a></li>
    <li><a href=""></a></li>
</ul>
```

**Type**: `(div>h2+p)*3` → `<C-y>,`
**Result**:
```html
<div>
    <h2></h2>
    <p></p>
</div>
<div>
    <h2></h2>
    <p></p>
</div>
<div>
    <h2></h2>
    <p></p>
</div>
```

---

## 📝 Part 4: Text and Attributes

### 10. Text Content (use `{}`)

**Type**: `a{Click me}` → `<C-y>,`
**Result**: `<a href="">Click me</a>`

**Type**: `p{This is a paragraph}` → `<C-y>,`
**Result**: `<p>This is a paragraph</p>`

**Type**: `ul>li{Item $}*3` → `<C-y>,`
**Result**:
```html
<ul>
    <li>Item 1</li>
    <li>Item 2</li>
    <li>Item 3</li>
</ul>
```

### 11. Custom Attributes (use `[]`)

**Type**: `a[href="https://google.com"]` → `<C-y>,`
**Result**: `<a href="https://google.com"></a>`

**Type**: `input[type="email" placeholder="Enter email"]` → `<C-y>,`
**Result**: `<input type="email" placeholder="Enter email">`

**Type**: `img[src="logo.png" alt="Logo"]` → `<C-y>,`
**Result**: `<img src="logo.png" alt="Logo">`

**Type**: `div[data-id="123"]` → `<C-y>,`
**Result**: `<div data-id="123"></div>`

---

## 🏗️ Part 5: Real-World Examples

### Example 1: Navigation Menu

**Type**: `nav>ul>li*4>a{Menu $}` → `<C-y>,`
**Result**:
```html
<nav>
    <ul>
        <li><a href="">Menu 1</a></li>
        <li><a href="">Menu 2</a></li>
        <li><a href="">Menu 3</a></li>
        <li><a href="">Menu 4</a></li>
    </ul>
</nav>
```

### Example 2: Card Layout

**Type**: `.container>.card*3>(.card-header>h3{Card $})+.card-body>p` → `<C-y>,`
**Result**:
```html
<div class="container">
    <div class="card">
        <div class="card-header">
            <h3>Card 1</h3>
        </div>
        <div class="card-body">
            <p></p>
        </div>
    </div>
    <div class="card">
        <div class="card-header">
            <h3>Card 2</h3>
        </div>
        <div class="card-body">
            <p></p>
        </div>
    </div>
    <div class="card">
        <div class="card-header">
            <h3>Card 3</h3>
        </div>
        <div class="card-body">
            <p></p>
        </div>
    </div>
</div>
```

### Example 3: Form

**Type**: `form>(.form-group>label{Name}+input[type="text" name="name"])+(.form-group>label{Email}+input:email)+button{Submit}` → `<C-y>,`
**Result**:
```html
<form>
    <div class="form-group">
        <label>Name</label>
        <input type="text" name="name">
    </div>
    <div class="form-group">
        <label>Email</label>
        <input type="email" name="">
    </div>
    <button>Submit</button>
</form>
```

### Example 4: Table

**Type**: `table>(thead>tr>th{Column $}*3)+(tbody>tr*2>td*3)` → `<C-y>,`
**Result**:
```html
<table>
    <thead>
        <tr>
            <th>Column 1</th>
            <th>Column 2</th>
            <th>Column 3</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </tbody>
</table>
```

### Example 5: Complete Page Structure

**Type**: `.container>(header>nav>ul>li*4>a{Link $})+(main>.section*3>h2{Section $}+p)+(footer>p{Copyright 2024})` → `<C-y>,`

---

## 🎯 Part 6: Emmet Shortcuts for Common Tags

You can use shortcuts instead of full tag names:

| Shortcut | Expands to | Example |
|----------|------------|---------|
| `input:email` | `<input type="email">` | Auto-completes email input |
| `input:password` | `<input type="password">` | Password input |
| `input:submit` | `<input type="submit">` | Submit button |
| `input:checkbox` | `<input type="checkbox">` | Checkbox |
| `input:radio` | `<input type="radio">` | Radio button |
| `btn` | `<button></button>` | Button |
| `a:link` | `<a href="http://"></a>` | Link with http |
| `link:css` | `<link rel="stylesheet" href="style.css">` | CSS link |

---

## 🏃 Practice Challenges

Try creating these from scratch using Emmet:

### Challenge 1: Blog Post
Create a blog post structure with:
- Article container
- Header with h1 title
- 3 paragraphs
- Footer with author and date

**Solution**: `article>(header>h1)+(p*3)+footer>(.author{John Doe}+.date{2024})`

### Challenge 2: Image Gallery
Create a gallery with:
- Container div
- 6 image cards, each with img and caption

**Solution**: `.gallery>.card*6>(img[src="image$.jpg"]+.caption{Image $})`

### Challenge 3: Contact Form
Create a form with:
- Name input
- Email input
- Message textarea
- Submit button

**Solution**: `form>.form-group*3>(label{Field $}+input[type="text"])+(textarea)+button:submit{Send}`

---

## 📚 Emmet for CSS

Emmet also works in CSS files!

**Type**: `m10` → `<C-y>,`
**Result**: `margin: 10px;`

**Type**: `p20` → `<C-y>,`
**Result**: `padding: 20px;`

**Type**: `w100p` → `<C-y>,`
**Result**: `width: 100%;`

**Type**: `df` → `<C-y>,`
**Result**: `display: flex;`

**Type**: `fz16` → `<C-y>,`
**Result**: `font-size: 16px;`

**Type**: `c#fff` → `<C-y>,`
**Result**: `color: #fff;`

---

## 🎓 Teaching Tips

### For Your Students:
1. **Start Simple**: Master single tags with classes first
2. **Build Up**: Add nesting one level at a time
3. **Practice Daily**: Try one new Emmet pattern each class
4. **Muscle Memory**: The more you use it, the faster you get

### Common Student Mistakes:
1. **Forgetting the comma**: `<C-y>,` needs both keys
2. **Wrong order**: Classes/IDs come AFTER the tag name
3. **Missing expansion**: Make sure you're in an HTML file
4. **Too complex**: Start simple, then combine patterns

### Pro Tips:
- Use `lorem` to generate dummy text: `p>lorem` → paragraph with Lorem Ipsum
- Use `lorem10` for specific word count: `p>lorem10` → 10 words
- Practice the same pattern multiple times to build muscle memory

---

## 🔥 Quick Reference

| Pattern | Result |
|---------|--------|
| `tag` | `<tag></tag>` |
| `.class` | `<div class="class"></div>` |
| `#id` | `<div id="id"></div>` |
| `tag>child` | Nested element |
| `tag+tag` | Sibling elements |
| `tag*3` | Multiply |
| `tag$*3` | Multiply with numbering |
| `tag{text}` | Text content |
| `tag[attr="value"]` | Custom attributes |
| `(group)` | Grouping |
| `!` | HTML5 boilerplate |

---

## 🚀 Next Steps

1. **Practice File**: Create `emmet-practice.html` and try all examples above
2. **Build a Page**: Use ONLY Emmet to build a complete landing page
3. **Speed Challenge**: Time yourself creating a navigation menu
4. **Teach Others**: The best way to learn is to teach!

**Remember**: The key to Emmet mastery is PRACTICE. Try to use it for every HTML task, even simple ones. In a week, you'll be 10x faster!

---

Happy Emmet-ing! 🎉
