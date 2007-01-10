Message-ID: <b647ffbd0701100655wd47af96y244c74d5227d6e85@domain.hid>
Date: Wed, 10 Jan 2007 15:55:04 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
In-Reply-To: <45A4F9CC.6070807@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3216_24499766.1168440904912"
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
	<45A4F18A.4040209@domain.hid>
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
	<45A4F9CC.6070807@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_3216_24499766.1168440904912
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> >>
> >> This will set xnintr_t::name to "" if name is NULL - intentionally?
> >
> > xnintr_t::name becomes a reference to RT_INTR::name. The later one
> > exists as long as the former anyway so there shoudn't be a broken
> > reference.
>
> Yes, this specifically addresses Mathias' concern about passed names
> that are temporary variables.
>
> It just leaves xnintr_t::name with an emptry string instead of "unknown"
> in some cases. Either xnintr_init needs to take care of this, or we
> should catch that case already here. I think empty strings in
> /proc/xenomai/irq are bad in case of shared IRQ lists.
>

Yes, this is what I've mentioned as a possible exception in my previous mail.

This patch should address it (although, it makes a code flow a bit
obscure but not too much :)


> Jan
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_3216_24499766.1168440904912
Content-Type: text/x-patch; name="intr_3.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="intr_3.patch"
X-Attachment-Id: f_ewrvjipx

LS0tIC4va3NyYy9za2lucy9uYXRpdmUvaW50ci1uZXcyLmMJMjAwNy0wMS0xMCAxNDo0NjowOC4z
MTk0NDIwMDAgKzAxMDAKKysrIC4va3NyYy9za2lucy9uYXRpdmUvaW50ci1uZXczLmMJMjAwNy0w
MS0xMCAxNTo1MToyMi45MzM5NzYwMDAgKzAxMDAKQEAgLTI0Miw3ICsyNDIsMTQgQEAgaW50IHJ0
X2ludHJfY3JlYXRlKFJUX0lOVFIgKmludHIsCiAJaWYgKHhucG9kX2FzeW5jaF9wKCkpCiAJCXJl
dHVybiAtRVBFUk07CiAKLQl4bm9iamVjdF9jb3B5X25hbWUoaW50ci0+bmFtZSwgbmFtZSk7CisJ
aWYgKG5hbWUpCisJCXhub2JqZWN0X2NvcHlfbmFtZShpbnRyLT5uYW1lLCBuYW1lKTsKKwllbHNl
CisJCS8qIEtlcm5lbC1zaWRlICJhbm9ueW1vdXMiIG9iamVjdHMgKG5hbWUgPT0gTlVMTCkgZ2V0
IHVuaXF1ZSBuYW1lcy4KKwkJICogTmV2ZXJ0aGVsZXNzLCB0aGV5IHdpbGwgbm90IGJlIGV4cG9y
dGVkIHZpYSB0aGUgcmVnaXN0cnkuICovCisJCXhub2JqZWN0X2NyZWF0ZV9uYW1lKGludHItPm5h
bWUsIHNpemVvZihpbnRyLT5uYW1lKSwKKwkJCSh2b2lkICopaW50cik7CisKIAl4bmludHJfaW5p
dCgmaW50ci0+aW50cl9iYXNlLCBpbnRyLT5uYW1lLCBpcnEsIGlzciwgaWFjaywgbW9kZSk7CiAj
aWYgZGVmaW5lZChfX0tFUk5FTF9fKSAmJiBkZWZpbmVkKENPTkZJR19YRU5PX09QVF9QRVJWQVNJ
VkUpCiAJeG5zeW5jaF9pbml0KCZpbnRyLT5zeW5jaF9iYXNlLCBYTlNZTkNIX1BSSU8pOwo=
------=_Part_3216_24499766.1168440904912--

