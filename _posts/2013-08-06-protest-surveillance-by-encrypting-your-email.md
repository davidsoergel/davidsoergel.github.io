---
title: Protest surveillance by encrypting your email.
author: David Soergel
layout: post
permalink: /2013/08/06/protest-surveillance-by-encrypting-your-email/
categories:
  - Mac
  - Security
---
In response to my recent suggestion that we encrypt as much email as possible (especially since it is finally convenient to use [MacGPG][1] with Mail.app on OSX 10.8&#8211; more on that later), a friend asked:

> Why encrypt? It just raises your profile. If I&#8217;ve got something to say that really needs to be private, I think email is right out.

[Good question][2], and one that takes some soul-searching.

<!--more-->

First of all: to me it&#8217;s a **matter of principle**. NSA: we want to read your email. DS: [fuck off][3].

Second: **encryption does actually work**, even against the NSA, so long as the key length is sufficient (I use 4 kb RSA keys, which should be OK for a while). So I may &#8220;raise my profile&#8221;&#8211;indeed, encryption apparently guarantees that the NSA will store the email indefinitely&#8211;but only in a generic sense that I become a more &#8220;suspicious&#8221; person; my content remains secure.

Third, as a corollary of the first two: I&#8217;m **flooding the system with noise as a form of protest**, and thereby contributing to the cost of the NSA programs (a token drop in the bucket, I know). If it becomes cost-prohibitive to store all encrypted emails (and, later, to decrypt them), then they&#8217;ll stop doing it, or at least they&#8217;ll have to reduce the storage term, or the quantity decrypted.

Similarly, the more completely innocent people they flag as &#8220;suspicious&#8221;, the less of the intended meaning that label will carry. Conversely, if a government wants to label me as suspicious when I&#8217;m clearly not, then my natural reaction is to be a dissident against that blatantly nutty government&#8211; in which case I welcome the label. If I become so &#8220;suspicious&#8221; that the NSA escalates by hacking my laptop directly, or by digging deeper into my cloud accounts, or by harassing my employer, or whatever, then that can only waste their time while potentially exposing them as ever more criminal and giving me and the ACLU and the EFF ever more grounds to sue.

Fourth: **good security practices remain effective against all other adversaries** besides the NSA, e.g. wayward sysadmins; random hackers; malevolent employers; insurance companies; whatever.

Fifth: for legal purposes, **encrypting something makes a strong assertion that the data is private**, so&#8211;even if the encryption is easy to break&#8211;anyone with knowledge of the content of my email can&#8217;t claim that they saw it inadvertently.

As for material that *really does* need to be private, like that plan we were talking about to hezbollah the intifadas with long-range nuclear embassy Yemen, I agree: absolutely no email, [Skype][4], phone calls, or snail mail (all of which gets at least envelopes [photographed and logged][5], if you didn&#8217;t catch that one). Stuff like that must be communicated **in person, naked, in a Faraday cage,** or by some other channel that has been very thoroughly designed to provide an insane level of security&#8211; which I haven&#8217;t yet thought through because I don&#8217;t actually need it.

The flip side of all this is that encrypting everything out of principle **intentionally throws up chaff** that could in the end just serve to make it harder for law enforcement to detect pedophiles and actual terrorists (in the real, non-diluted sense) and whatnot&#8211; cf. yesterday&#8217;s [shutdown of a pile of Tor sites][6], at least some of which probably were really horrible. Such crimes can and should be investigated by standard procedures, including digital snooping with appropriate warrants.

But I&#8217;m sure you agree that mass collection of everything is a bridge too far, so I have no problem putting up some resistance against that even if I&#8217;m accused of thereby effectively harboring criminals. If the cost of freedom is a few more heinous crimes, so be it; we have to accept at least a little bit of unpleasantness if the only alternative is to cower in the face of a police state. Liberty/security/deserve neither/etc. etc.

As for designing protocols or algorithms to provide additional security beyond basic GPG encryption: that is seriously [best left to experts][7]. For instance:

> Or maybe an encrypted message sent in two halves, as separate emails…

I think that provides no benefit at all. Anybody who has access to one half also has access to the other (they&#8217;re certain to be sent over the same wires, stored on the same servers, etc.). Maybe it makes decryption infinitesimally harder because you have to match up the halves first, but that is trivial compared to the rest of the surveillance and decryption that would have to happen anyway.

In any case, the upshot is that I do encourage anyone with GPG set up to use it as much as possible; my key is [191C21C3][8]. For those not hooked up yet, I&#8217;ll write up a quick howto soon&#8211; it&#8217;s really easy.

 [1]: https://gpgtools.org/
 [2]: http://www.techrepublic.com/blog/it-security/does-using-encryption-make-you-a-bigger-target-for-the-nsa/
 [3]: https://en.wikipedia.org/wiki/Fourth_Amendment_to_the_United_States_Constitution
 [4]: http://www.theguardian.com/world/2013/jul/11/microsoft-nsa-collaboration-user-data
 [5]: https://en.wikipedia.org/wiki/Mail_Isolation_Control_and_Tracking
 [6]: http://boingboing.net/2013/08/04/anonymous-web-host-shut-down.html
 [7]: https://www.schneier.com/blog/archives/2011/04/schneiers_law.html
 [8]: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x36D5FFC7191C21C3