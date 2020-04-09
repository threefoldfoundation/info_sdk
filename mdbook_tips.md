
### MDBOOK HOW TO :-

after changing any file, build has to be run 
cd into the repo directory then run this command :-

```
mdbook build info_threefold -d docs

```

 - changeing the title :- 
    - from book.toml file
  ```
  title = "Threefold Foundation"
  ```
  
 - changing the default theme
    - from book.toml file
```
default-theme = "Rust"
```

- Runing mdbook server :- 

**use -p for specifying port number**

cd into the repo directory then run this command :-
```
mdbook serve info_threefold -d docs -n 0.0.0.0
```


- Sidbar foldable setting, enabled by adding this part to book.toml file :-

```
[output.html.fold]
enable = true
level = 0

```
