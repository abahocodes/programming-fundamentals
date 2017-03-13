# You already know about maps!!!

## Quick definition
Let me start this lesson by assuring you that you already know about maps. You use them everyday and all we are doing here
is learning how to use maps in code. Maps are a set of unique key-value representations of data. What do I mean by "key-value representation"?

## Key-Value?
A key-value mapping is a matching of a key to a value. For example, when you open the dictionary, a map that you use in
the real world, when you search for the word `crazy` (our key), you expect to find the definition `mentally deranged, especially as manifested in a wild or aggressive way` (our value).
Now, this key-value pairing is not unique because there are other words that could possibly also have the same definition as crazy.  

## Uniqueness?
In code our key-value representations must be `unique`. That means for a given key, there can only be ONE value. For example, if we searched for Beyoncé (our key),
we expect to see only one person (our value). Since I like Beyoncé so much, I'd like to think that there is only one person in the world who is married to Jay-Z, performed "Single Ladies", and deserves
all the Grammys in the world. This is a UNIQUE mapping. There is ONLY one person for the key Beyoncé.

## Now let's write some code

***NOTE***: Open Processing, paste the code below, run it, and please understand how it works.

```
import java.util.Map;

// Note the HashMap's "key" is a String and "value" is an Integer
HashMap<String,Integer> hm = new HashMap<String,Integer>();

// Putting key-value pairs in the HashMap
hm.put("Ava", 1);
hm.put("Cait", 35);
hm.put("Casey", 36);

// Using an enhanced loop to interate over each entry
for (Map.Entry me : hm.entrySet()) {
  print(me.getKey() + " is ");
  println(me.getValue());
}

// We can also access values by their key
int val = hm.get("Casey");
println("Casey is " + val);
```

## Wrap Up
In the example, we are mapping Strings to Integers. Keep in mind we can map a lot more types to a whole bunch of other types.
