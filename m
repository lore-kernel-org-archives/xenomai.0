Message-ID: <b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
Date: Wed, 10 Jan 2007 14:49:46 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
In-Reply-To: <45A4DDA8.6090800@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2528_30819576.1168436986633"
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
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

------=_Part_2528_30819576.1168436986633
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I suppose, one more thing was missed. intr_reg.patch is to address it.

intr_swap.patch - to be safe with xnintr_t::name in all cases. In
particular, the reported crash should disappear without other
additional patches.


-- 
Best regards,
Dmitry Adamushko

------=_Part_2528_30819576.1168436986633
Content-Type: text/x-patch; name="intr_reg.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="intr_reg.patch"
X-Attachment-Id: f_ewrt6ln8

LS0tIC4va3NyYy9za2lucy9uYXRpdmUvaW50ci5jCTIwMDYtMDYtMTUgMTQ6MTU6NDQuMDAwMDAw
MDAwICswMjAwCisrKyAuL2tzcmMvc2tpbnMvbmF0aXZlL2ludHItbmV3LmMJMjAwNy0wMS0xMCAx
NDo0NToyNi4zMjA1NjUwMDAgKzAxMDAKQEAgLTIyMyw2ICsyMjMsNyBAQCBzdGF0aWMgeG5wbm9k
ZV90IF9faW50cl9wbm9kZSA9IHsKICAqCiAgKiAtIEtlcm5lbCBtb2R1bGUgaW5pdGlhbGl6YXRp
b24vY2xlYW51cCBjb2RlCiAgKiAtIEtlcm5lbC1iYXNlZCB0YXNrCisgKiAtIFVzZXItc3BhY2Ug
dGFzawogICoKICAqIFJlc2NoZWR1bGluZzogcG9zc2libGUuCiAgKgpAQCAtMjYyLDExICsyNjMs
MjEgQEAgaW50IHJ0X2ludHJfY3JlYXRlKFJUX0lOVFIgKmludHIsCiAJLyogPCE+IFNpbmNlIHhu
cmVnaXN0ZXJfZW50ZXIoKSBtYXkgcmVzY2hlZHVsZSwgb25seSByZWdpc3RlcgogCSAgIGNvbXBs
ZXRlIG9iamVjdHMsIHNvIHRoYXQgdGhlIHJlZ2lzdHJ5IGNhbm5vdCByZXR1cm4gaGFuZGxlcyB0
bwogCSAgIGhhbGYtYmFrZWQgb2JqZWN0cy4uLiAqLworCWlmICghZXJyICYmIG5hbWUpIHsKKwkJ
eG5wbm9kZV90ICpwbm9kZSA9ICZfX2ludHJfcG5vZGU7CiAKLQlpZiAoIWVycikKLQkJZXJyID0K
LQkJICAgIHhucmVnaXN0cnlfZW50ZXIoaW50ci0+bmFtZSwgaW50ciwgJmludHItPmhhbmRsZSwK
LQkJCQkgICAgICZfX2ludHJfcG5vZGUpOworCQlpZiAoISpuYW1lKSB7CisJCQkvKiBTaW5jZSB0
aGlzIGlzIGFuIGFub255bW91cyBvYmplY3QgKGVtcHR5IG5hbWUgb24gZW50cnkpCisJCQkgKiBm
cm9tIHVzZXItc3BhY2UsIGl0IGdldHMgcmVnaXN0ZXJlZCB1bmRlciBhbiB1bmlxdWUKKwkJCSAq
IGludGVybmFsIG5hbWUgYnV0IGlzIG5vdCBleHBvcnRlZCB0aHJvdWdoIC9wcm9jLiAqLworCQkJ
eG5vYmplY3RfY3JlYXRlX25hbWUoaW50ci0+bmFtZSwgc2l6ZW9mKGludHItPm5hbWUpLAorCQkJ
CSh2b2lkICopaW50cik7CisJCQlwbm9kZSA9IE5VTEw7CisJCX0KKworCQllcnIgPSB4bnJlZ2lz
dHJ5X2VudGVyKGludHItPm5hbWUsIGludHIsICZpbnRyLT5oYW5kbGUsIHBub2RlKTsKKwl9CQor
CQogI2VuZGlmIC8qIENPTkZJR19YRU5PX09QVF9SRUdJU1RSWSAqLwogCiAJaWYgKGVycikK
------=_Part_2528_30819576.1168436986633
Content-Type: text/x-patch; name="intr_swap.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="intr_swap.patch"
X-Attachment-Id: f_ewrt78yz

LS0tIC4va3NyYy9za2lucy9uYXRpdmUvaW50ci1uZXcuYwkyMDA3LTAxLTEwIDE0OjQ1OjI2LjMy
MDU2NTAwMCArMDEwMAorKysgLi9rc3JjL3NraW5zL25hdGl2ZS9pbnRyLW5ldzIuYwkyMDA3LTAx
LTEwIDE0OjQ2OjA4LjMxOTQ0MjAwMCArMDEwMApAQCAtMjQyLDggKzI0Miw4IEBAIGludCBydF9p
bnRyX2NyZWF0ZShSVF9JTlRSICppbnRyLAogCWlmICh4bnBvZF9hc3luY2hfcCgpKQogCQlyZXR1
cm4gLUVQRVJNOwogCi0JeG5pbnRyX2luaXQoJmludHItPmludHJfYmFzZSwgbmFtZSwgaXJxLCBp
c3IsIGlhY2ssIG1vZGUpOwogCXhub2JqZWN0X2NvcHlfbmFtZShpbnRyLT5uYW1lLCBuYW1lKTsK
Kwl4bmludHJfaW5pdCgmaW50ci0+aW50cl9iYXNlLCBpbnRyLT5uYW1lLCBpcnEsIGlzciwgaWFj
aywgbW9kZSk7CiAjaWYgZGVmaW5lZChfX0tFUk5FTF9fKSAmJiBkZWZpbmVkKENPTkZJR19YRU5P
X09QVF9QRVJWQVNJVkUpCiAJeG5zeW5jaF9pbml0KCZpbnRyLT5zeW5jaF9iYXNlLCBYTlNZTkNI
X1BSSU8pOwogCWludHItPnBlbmRpbmcgPSAwOwo=
------=_Part_2528_30819576.1168436986633--

