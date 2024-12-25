# sw_encoder

Do you have a huge object you want to use in your program but can't because of the char limit? Fear not, since you can abuse the properties to hold the required value!

To achieve this, do the following:

- Acquire your value. Let's assume it's `{1,2,[3]={4}}` for this example
- Go to a Lua interpreter (an online one works), copy the code from `encode.lua` and at the end add `print(encodeToController("my_value", {1,2,[3]={4}}))`, where `"my_value"` is the name you want the text property to have (you can change it later), and the value is, well, the value
- Copy the resulting code and paste it into the `.xml` of a random microcontroller you don't need
- Open the microcontroller you just edited in Stormworks and copy the text property over to the microcontroller you are working on
- Add the code from `decode.lua` to your microcontroller code (it is around 700 chars, however this process can save you thousands. You also can minify the file first). Now all you have to do to retrieve your value is `my_value = parse(pgt("my_value"))`, where `"my_value"` is the name of the property
- ???
- Profit
