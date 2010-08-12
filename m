From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>
References: <76E258664B189C4CBEF125491CA11ECC9458403922@domain.hid>
	<76E258664B189C4CBEF125491CA11ECC9458403925@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Aug 2010 09:12:39 +0200
Message-ID: <1281597159.1730.71.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] 2.6.32.18/x86 (Ubuntu) hangs at boot w/ Xenomai
 2.5.3 [was: HELP]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Zafar Iqbal <Zafar.Iqbal2@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On Thu, 2010-08-12 at 11:46 +0530, Zafar Iqbal wrote:
> Dear Sir,
> 
> 
> I am Using Ubuntu 10.4 in my system with kernel version 2.6.32.18.
> I downloaded xenomai-2.5.3 and ptached into linux-2.6.32.18 after that I compiled the whole kenel.using make.
> After that I made the image of the compiled kernel : make bzImage
> then copied the image to the location as in the boot folder with the following command cp arch/x86/boot/bzImage /boot/vmlinuz-2.6.32.18-xenomai-2.5.3
> then I updated my GRUB with the command update-grub.
> 
> When I Tried to reboot the System with the Xenomai patched Kernel my system hanged up and it is not able to boot with the new kernel image.
> 
> Can you please suggest whats the wrong here.

A few hints:

- that question from mainstream x86 distro users is definitely a FAQ on
our mailing list. Did you have a look at the mailing list archive, to
find common answers to this problem?
https://mail.gna.org/public/xenomai-help/

- Did you read the TROUBLESHOOTING file at the top of the Xenomai tree
and on our website?
http://www.xenomai.org/documentation/xenomai-2.5/TROUBLESHOOTING

- Did you read this FAQ?
http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86_kernel

- Do you mind sending a bit more information than "my system hanged up"?
Any boot log to share? A kernel config file maybe? Did you disable the
quiet boot option to see kernel messages while booting? Are there any
messages at all? Our mail archive is full of advices regarding the way
to troubleshoot a boot issue on x86, make sure to read them first.

- Please always provide a meaningful subject line, so that people having
the same issue could later find and reuse the information from that
thread.  "HELP" - particularly on a list called xenomai-help - does not
qualify, at all. Because it could be seen as a waste of time by your
recipients, it may even be counter-productive, and tends to bury your
mail.

- Please stop posting to xenomai-help-owner, really. This address is for
sending requests related to your mailing list subscription, only.

- Please do not re-post the very same question multiple times within
less than 24 hours. It makes no sense; you can check that your previous
message did arrive in our mail archive, so no need to spam the list with
a rehash of your previous post. If people did not answer you yet, it may
be because: 1) you did not provide sufficient input for them to think
about your issue, 2) they don't have time to answer you at the moment,
3) they don't care, 4) they don't know, or any combination thereof.

> 
> 
> Thanks and Regards,
> Zafar
> 
> 
> 

-- 
Philippe.



