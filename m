MIME-Version: 1.0
Date: Wed, 22 Sep 2010 21:24:59 +0200
Message-ID: <AANLkTiky8ijwfEZ+6j9etMz1is20UNCyJm-d48NVwZR-@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=001636af0230f4a97b0490de19fa
Subject: [Xenomai-help] pSOS+ skin: unique task names
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--001636af0230f4a97b0490de19fa
Content-Type: text/plain; charset=ISO-8859-1

Hello

I have a question related to the pSOS+ skin. It might be relevant for other
skins as well.

What I observe is that the taskname while creating a task should be unique.
If I use the same taskname twice, I get a failure. I think this is not a
restriction in the real pSOS+ implementation, so this means that some
applications will not be portable.

I second issue I see is that since the main task is also registered under
the name "MAIN". This means I can have only 1 process that makes use of the
pSOS skin. If I start a second process, an error code is returned since the
"MAIN" task already exists (it is automatically created during the
initialization phase).

I made a workaround for this by appending the PID to the task names created
in the application.
I also to the same for the "MAIN" task.

After applying the change and starting the same application 2 times, I get
following result when I dump the scheduler information:
# cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0  0      idle    -1      -         master     R          ROOT
  0  1046   rt       0      5370t     psos       D          MAIN_1046
  0  1048   rt      10      100t      psos       D          TST5_1046
  0  1049   rt      64      0t        psos       Wl         TTT0_1048
  0  1050   rt      64      0t        psos       Wl         TTT1_1048
  0  1051   rt      64      0t        psos       Wl         TTT2_1048
  0  1052   rt      64      0t        psos       Wl         TTT3_1048
  0  1053   rt      64      0t        psos       Wl         TTT4_1048
  0  1054   rt      64      0t        psos       Wl         TTT5_1048
  0  1055   rt      64      0t        psos       Wl         TTT6_1048
  0  1056   rt      64      0t        psos       Wl         TTT7_1048
  0  1057   rt      64      0t        psos       Wl         TTT8_1048
  0  1058   rt      64      0t        psos       Wl         TTT9_1048
  0  1059   rt       0      6802t     psos       D          MAIN_1059
  0  1061   rt      10      100t      psos       D          TST5_1059
  0  1062   rt      64      0t        psos       Wl         TTT0_1061
  0  1063   rt      64      0t        psos       Wl         TTT1_1061
  0  1064   rt      64      0t        psos       Wl         TTT2_1061
  0  1065   rt      64      0t        psos       Wl         TTT3_1061
  0  1066   rt      64      0t        psos       Wl         TTT4_1061
  0  1067   rt      64      0t        psos       Wl         TTT5_1061
  0  1068   rt      64      0t        psos       Wl         TTT6_1061
  0  1069   rt      64      0t        psos       Wl         TTT7_1061
  0  1070   rt      64      0t        psos       Wl         TTT8_1061
  0  1071   rt      64      0t        psos       Wl         TTT9_1061

Now the question is: is this the right technique or do other means exist to
start multiple clients (processes) of the pSOS skin.

It might be better to use a unique ID per "application" instead of the PID
since now the full name depends on the actual thread that has created the
new process. To be more clear: all tasks belonging to a certain process
could be appended with the same unique number.

Please comment.

Best regards,
Ronny

--001636af0230f4a97b0490de19fa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SGVsbG88YnI+Cjxicj4KSSBoYXZlIGEgcXVlc3Rpb24gcmVsYXRlZCB0byB0aGUgcFNPUysgc2tp
bi4gSXQgbWlnaHQgYmUgcmVsZXZhbnQgZm9yIG90aGVyIHNraW5zIGFzIHdlbGwuPGJyPgo8YnI+
CldoYXQgSSBvYnNlcnZlIGlzIHRoYXQgdGhlIHRhc2tuYW1lIHdoaWxlIGNyZWF0aW5nIGEgdGFz
ayBzaG91bGQgYmUgdW5pcXVlLjxicj4KSWYgSSB1c2UgdGhlIHNhbWUgdGFza25hbWUgdHdpY2Us
IEkgZ2V0IGEgZmFpbHVyZS4gSSB0aGluayB0aGlzIGlzIG5vdCBhCiByZXN0cmljdGlvbiBpbiB0
aGUgcmVhbCBwU09TKyBpbXBsZW1lbnRhdGlvbiwgc28gdGhpcyBtZWFucyB0aGF0IHNvbWUgCmFw
cGxpY2F0aW9ucyB3aWxsIG5vdCBiZSBwb3J0YWJsZS48YnI+Cjxicj4KSSBzZWNvbmQgaXNzdWUg
SSBzZWUgaXMgdGhhdCBzaW5jZSB0aGUgbWFpbiB0YXNrIGlzIGFsc28gcmVnaXN0ZXJlZCAKdW5k
ZXIgdGhlIG5hbWUgJnF1b3Q7TUFJTiZxdW90Oy4gVGhpcyBtZWFucyBJIGNhbiBoYXZlIG9ubHkg
MSBwcm9jZXNzIHRoYXQgbWFrZXMgCnVzZSBvZiB0aGUgcFNPUyBza2luLiBJZiBJIHN0YXJ0IGEg
c2Vjb25kIHByb2Nlc3MsIGFuIGVycm9yIGNvZGUgaXMgCnJldHVybmVkIHNpbmNlIHRoZSAmcXVv
dDtNQUlOJnF1b3Q7IHRhc2sgYWxyZWFkeSBleGlzdHMgKGl0IGlzIGF1dG9tYXRpY2FsbHkgCmNy
ZWF0ZWQgZHVyaW5nIHRoZSBpbml0aWFsaXphdGlvbiBwaGFzZSkuIDxicj4KPGJyPgpJIG1hZGUg
YSB3b3JrYXJvdW5kIGZvciB0aGlzIGJ5IGFwcGVuZGluZyB0aGUgUElEIHRvIHRoZSB0YXNrIG5h
bWVzIGNyZWF0ZWQgaW4gdGhlIGFwcGxpY2F0aW9uLjxicj4KSSBhbHNvIHRvIHRoZSBzYW1lIGZv
ciB0aGUgJnF1b3Q7TUFJTiZxdW90OyB0YXNrLjxicj4KPGJyPgpBZnRlciBhcHBseWluZyB0aGUg
Y2hhbmdlIGFuZCBzdGFydGluZyB0aGUgc2FtZSBhcHBsaWNhdGlvbiAyIHRpbWVzLCBJIApnZXQg
Zm9sbG93aW5nIHJlc3VsdCB3aGVuIEkgZHVtcCB0aGUgc2NoZWR1bGVyIGluZm9ybWF0aW9uOjxi
cj4KIyBjYXQgL3Byb2MveGVub21haS9zY2hlZDxicj4KQ1BVoCBQSUSgoKAgQ0xBU1OgIFBSSaCg
oKCgIFRJTUVPVVSgoCBUSU1FQkFTRaCgIFNUQVSgoKCgoKAgTkFNRTxicj4KoCAwoCAwoKCgoKAg
aWRsZaCgoCAtMaCgoKCgIC2goKCgoKCgoCBtYXN0ZXKgoKCgIFKgoKCgoKCgoKAgUk9PVDxicj4K
oCAwoCAxMDQ2oKAgcnSgoKCgoKAgMKCgoKCgIDUzNzB0oKCgoCBwc29zoKCgoKCgIESgoKCgoKCg
oKAgTUFJTl8xMDQ2PGJyPgqgIDCgIDEwNDigoCBydKCgoKCgIDEwoKCgoKAgMTAwdKCgoKCgIHBz
b3OgoKCgoKAgRKCgoKCgoKCgoCBUU1Q1XzEwNDY8YnI+CqAgMKAgMTA0OaCgIHJ0oKCgoKAgNjSg
oKCgoCAwdKCgoKCgoKAgcHNvc6CgoKCgoCBXbKCgoKCgoKCgIFRUVDBfMTA0ODxicj4KoCAwoCAx
MDUwoKAgcnSgoKCgoCA2NKCgoKCgIDB0oKCgoKCgoCBwc29zoKCgoKCgIFdsoKCgoKCgoKAgVFRU
MV8xMDQ4PGJyPgqgIDCgIDEwNTGgoCBydKCgoKCgIDY0oKCgoKAgMHSgoKCgoKCgIHBzb3OgoKCg
oKAgV2ygoKCgoKCgoCBUVFQyXzEwNDg8YnI+CqAgMKAgMTA1MqCgIHJ0oKCgoKAgNjSgoKCgoCAw
dKCgoKCgoKAgcHNvc6CgoKCgoCBXbKCgoKCgoKCgIFRUVDNfMTA0ODxicj4KoCAwoCAxMDUzoKAg
cnSgoKCgoCA2NKCgoKCgIDB0oKCgoKCgoCBwc29zoKCgoKCgIFdsoKCgoKCgoKAgVFRUNF8xMDQ4
PGJyPgqgIDCgIDEwNTSgoCBydKCgoKCgIDY0oKCgoKAgMHSgoKCgoKCgIHBzb3OgoKCgoKAgV2yg
oKCgoKCgoCBUVFQ1XzEwNDg8YnI+CqAgMKAgMTA1NaCgIHJ0oKCgoKAgNjSgoKCgoCAwdKCgoKCg
oKAgcHNvc6CgoKCgoCBXbKCgoKCgoKCgIFRUVDZfMTA0ODxicj4KoCAwoCAxMDU2oKAgcnSgoKCg
oCA2NKCgoKCgIDB0oKCgoKCgoCBwc29zoKCgoKCgIFdsoKCgoKCgoKAgVFRUN18xMDQ4PGJyPgqg
IDCgIDEwNTegoCBydKCgoKCgIDY0oKCgoKAgMHSgoKCgoKCgIHBzb3OgoKCgoKAgV2ygoKCgoKCg
oCBUVFQ4XzEwNDg8YnI+CqAgMKAgMTA1OKCgIHJ0oKCgoKAgNjSgoKCgoCAwdKCgoKCgoKAgcHNv
c6CgoKCgoCBXbKCgoKCgoKCgIFRUVDlfMTA0ODxicj4KoCAwoCAxMDU5oKAgcnSgoKCgoKAgMKCg
oKCgIDY4MDJ0oKCgoCBwc29zoKCgoKCgIESgoKCgoKCgoKAgTUFJTl8xMDU5PGJyPgqgIDCgIDEw
NjGgoCBydKCgoKCgIDEwoKCgoKAgMTAwdKCgoKCgIHBzb3OgoKCgoKAgRKCgoKCgoKCgoCBUU1Q1
XzEwNTk8YnI+CqAgMKAgMTA2MqCgIHJ0oKCgoKAgNjSgoKCgoCAwdKCgoKCgoKAgcHNvc6CgoKCg
oCBXbKCgoKCgoKCgIFRUVDBfMTA2MTxicj4KoCAwoCAxMDYzoKAgcnSgoKCgoCA2NKCgoKCgIDB0
oKCgoKCgoCBwc29zoKCgoKCgIFdsoKCgoKCgoKAgVFRUMV8xMDYxPGJyPgqgIDCgIDEwNjSgoCBy
dKCgoKCgIDY0oKCgoKAgMHSgoKCgoKCgIHBzb3OgoKCgoKAgV2ygoKCgoKCgoCBUVFQyXzEwNjE8
YnI+CqAgMKAgMTA2NaCgIHJ0oKCgoKAgNjSgoKCgoCAwdKCgoKCgoKAgcHNvc6CgoKCgoCBXbKCg
oKCgoKCgIFRUVDNfMTA2MTxicj4KoCAwoCAxMDY2oKAgcnSgoKCgoCA2NKCgoKCgIDB0oKCgoKCg
oCBwc29zoKCgoKCgIFdsoKCgoKCgoKAgVFRUNF8xMDYxPGJyPgqgIDCgIDEwNjegoCBydKCgoKCg
IDY0oKCgoKAgMHSgoKCgoKCgIHBzb3OgoKCgoKAgV2ygoKCgoKCgoCBUVFQ1XzEwNjE8YnI+CqAg
MKAgMTA2OKCgIHJ0oKCgoKAgNjSgoKCgoCAwdKCgoKCgoKAgcHNvc6CgoKCgoCBXbKCgoKCgoKCg
IFRUVDZfMTA2MTxicj4KoCAwoCAxMDY5oKAgcnSgoKCgoCA2NKCgoKCgIDB0oKCgoKCgoCBwc29z
oKCgoKCgIFdsoKCgoKCgoKAgVFRUN18xMDYxPGJyPgqgIDCgIDEwNzCgoCBydKCgoKCgIDY0oKCg
oKAgMHSgoKCgoKCgIHBzb3OgoKCgoKAgV2ygoKCgoKCgoCBUVFQ4XzEwNjE8YnI+CqAgMKAgMTA3
MaCgIHJ0oKCgoKAgNjSgoKCgoCAwdKCgoKCgoKAgcHNvc6CgoKCgoCBXbKCgoKCgoKCgIFRUVDlf
MTA2MTxicj4KPGJyPgpOb3cgdGhlIHF1ZXN0aW9uIGlzOiBpcyB0aGlzIHRoZSByaWdodCB0ZWNo
bmlxdWUgb3IgZG8gb3RoZXIgbWVhbnMgZXhpc3QgdG8gc3RhcnQgbXVsdGlwbGUgY2xpZW50cyAo
cHJvY2Vzc2VzKSBvZiB0aGUgcFNPUyBza2luLjxicj4KPGJyPgpJdCBtaWdodCBiZSBiZXR0ZXIg
dG8gdXNlIGEgdW5pcXVlIElEIHBlciAmcXVvdDthcHBsaWNhdGlvbiZxdW90OyBpbnN0ZWFkIG9m
IHRoZSAKUElEIHNpbmNlIG5vdyB0aGUgZnVsbCBuYW1lIGRlcGVuZHMgb24gdGhlIGFjdHVhbCB0
aHJlYWQgdGhhdCBoYXMgCmNyZWF0ZWQgdGhlIG5ldyBwcm9jZXNzLiBUbyBiZSBtb3JlIGNsZWFy
OiBhbGwgdGFza3MgYmVsb25naW5nIHRvIGEgCmNlcnRhaW4gcHJvY2VzcyBjb3VsZCBiZSBhcHBl
bmRlZCB3aXRoIHRoZSBzYW1lIHVuaXF1ZSBudW1iZXIuPGJyPgo8YnI+ClBsZWFzZSBjb21tZW50
Ljxicj4KPGJyPgpCZXN0IHJlZ2FyZHMsPGJyPgpSb25ueTxicj4K
--001636af0230f4a97b0490de19fa--

