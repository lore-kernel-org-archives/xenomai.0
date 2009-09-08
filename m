MIME-Version: 1.0
Date: Tue, 8 Sep 2009 16:59:38 -0300
Message-ID: <7a15153d0909081259o47b0fcb7k46f679e7dfe83456@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=001485f19a0e0cfc2304731668d0
Subject: [Xenomai-help] High Latency on PXA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--001485f19a0e0cfc2304731668d0
Content-Type: text/plain; charset=ISO-8859-1

I'm running Xenomai 2.4.8 with kernel 2.6.27 on a Voipac development kit
with PXA270 processor.

Once applied a patch (Thanks Giles) everythink looks to run ok , but running
the latency test program i got:

root@domain.hid$ ./latency -p 3000
== Sampling period: 3000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 3000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      14.153|      14.769|      39.999|       0|      14.153|
39.999
RTD|      14.153|      17.538|     209.538|       0|      14.153|
209.538
RTD|      14.153|      56.923|   13829.846|       4|      14.153|
13829.846
RTD|      13.846|      57.538|   13769.538|       8|      13.846|
13829.846
RTD|      14.153|      56.923|   13816.615|      12|      13.846|
13829.846
RTD|      14.153|      57.846|   13833.846|      16|      13.846|
13833.846
RTD|      14.153|      57.230|   13827.692|      20|      13.846|
13833.846
RTD|      14.153|      57.538|   13812.615|      24|      13.846|
13833.846
RTD|      13.846|      56.923|   13823.999|      28|      13.846|
13833.846
RTD|      14.153|      57.538|   13812.307|      32|      13.846|
13833.846
RTD|      14.153|     200.923|   13833.538|      36|      13.846|
13833.846
RTD|      13.846|     201.846|   14044.923|      40|      13.846|
14044.923
RTD|      13.846|     201.538|   14044.307|      44|      13.846|
14044.923
RTD|      13.846|     201.538|   14043.384|      48|      13.846|
14044.923

There are overrun and max. latency is to high ! Is there something to fix
it.

Running with tasks with more than 10ms there are overrun , and the results
looks better ...

root@domain.hid$ ./latency -p 10000
== Sampling period: 10000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 10000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      13.538|      14.769|      19.999|       0|      13.538|
19.999
RTD|      13.538|      18.769|      81.538|       0|      13.538|
81.538
RTD|      13.230|      85.846|    6833.538|       0|      13.230|
6833.538
RTD|      13.538|      87.076|    6807.999|       0|      13.230|
6833.538
RTD|      13.230|      85.230|    6827.999|       0|      13.230|
6833.538
RTD|      13.538|      87.384|    6804.307|       0|      13.230|
6833.538
RTD|      13.230|      85.846|    6841.846|       0|      13.230|
6841.846
RTD|      13.230|      87.999|    6801.538|       0|      13.230|
6841.846
RTD|      13.230|      84.923|    6820.615|       0|      13.230|
6841.846
RTD|      13.230|      88.615|    6795.692|       0|      13.230|
6841.846



Thanks !x

--001485f19a0e0cfc2304731668d0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SSYjMzk7bSBydW5uaW5nIFhlbm9tYWkgMi40Ljggd2l0aCBrZXJuZWwgMi42LjI3IG9uIGEgVm9p
cGFjIGRldmVsb3BtZW50IGtpdCB3aXRoIFBYQTI3MCBwcm9jZXNzb3IuIDxicj48YnI+T25jZSBh
cHBsaWVkIGEgcGF0Y2ggKFRoYW5rcyBHaWxlcykgZXZlcnl0aGluayBsb29rcyB0byBydW4gb2sg
LCBidXQgcnVubmluZyB0aGUgbGF0ZW5jeSB0ZXN0IHByb2dyYW0gaSBnb3Q6PGJyPjxicj4Kcm9v
dEB2cGFjMjcwOi91c3IveGVub21haS9iaW4kIC4vbGF0ZW5jeSAtcCAzMDAwPGJyPj09IFNhbXBs
aW5nIHBlcmlvZDogMzAwMCB1czxicj49PSBUZXN0IG1vZGU6IHBlcmlvZGljIHVzZXItbW9kZSB0
YXNrPGJyPj09IEFsbCByZXN1bHRzIGluIG1pY3Jvc2Vjb25kczxicj53YXJtaW5nIHVwLi4uPGJy
PlJUVHygIDAwOjAwOjAxoCAocGVyaW9kaWMgdXNlci1tb2RlIHRhc2ssIDMwMDAgdXMgcGVyaW9k
LCBwcmlvcml0eSA5OSk8YnI+ClJUSHwtLS0tLWxhdCBtaW58LS0tLS1sYXQgYXZnfC0tLS0tbGF0
IG1heHwtb3ZlcnJ1bnwtLS0tbGF0IGJlc3R8LS0tbGF0IHdvcnN0PGJyPlJURHygoKCgoCAxNC4x
NTN8oKCgoKAgMTQuNzY5fKCgoKCgIDM5Ljk5OXygoKCgoKAgMHygoKCgoCAxNC4xNTN8oKCgoKAg
MzkuOTk5PGJyPlJURHygoKCgoCAxNC4xNTN8oKCgoKAgMTcuNTM4fKCgoKAgMjA5LjUzOHygoKCg
oKAgMHygoKCgoCAxNC4xNTN8oKCgoCAyMDkuNTM4PGJyPgpSVER8oKCgoKAgMTQuMTUzfKCgoKCg
IDU2LjkyM3ygoCAxMzgyOS44NDZ8oKCgoKCgIDR8oKCgoKAgMTQuMTUzfKCgIDEzODI5Ljg0Njxi
cj5SVER8oKCgoKAgMTMuODQ2fKCgoKCgIDU3LjUzOHygoCAxMzc2OS41Mzh8oKCgoKCgIDh8oKCg
oKAgMTMuODQ2fKCgIDEzODI5Ljg0Njxicj5SVER8oKCgoKAgMTQuMTUzfKCgoKCgIDU2LjkyM3yg
oCAxMzgxNi42MTV8oKCgoKAgMTJ8oKCgoKAgMTMuODQ2fKCgIDEzODI5Ljg0Njxicj4KUlREfKCg
oKCgIDE0LjE1M3ygoKCgoCA1Ny44NDZ8oKAgMTM4MzMuODQ2fKCgoKCgIDE2fKCgoKCgIDEzLjg0
NnygoCAxMzgzMy44NDY8YnI+UlREfKCgoKCgIDE0LjE1M3ygoKCgoCA1Ny4yMzB8oKAgMTM4Mjcu
NjkyfKCgoKCgIDIwfKCgoKCgIDEzLjg0NnygoCAxMzgzMy44NDY8YnI+UlREfKCgoKCgIDE0LjE1
M3ygoKCgoCA1Ny41Mzh8oKAgMTM4MTIuNjE1fKCgoKCgIDI0fKCgoKCgIDEzLjg0NnygoCAxMzgz
My44NDY8YnI+ClJURHygoKCgoCAxMy44NDZ8oKCgoKAgNTYuOTIzfKCgIDEzODIzLjk5OXygoKCg
oCAyOHygoKCgoCAxMy44NDZ8oKAgMTM4MzMuODQ2PGJyPlJURHygoKCgoCAxNC4xNTN8oKCgoKAg
NTcuNTM4fKCgIDEzODEyLjMwN3ygoKCgoCAzMnygoKCgoCAxMy44NDZ8oKAgMTM4MzMuODQ2PGJy
PlJURHygoKCgoCAxNC4xNTN8oKCgoCAyMDAuOTIzfKCgIDEzODMzLjUzOHygoKCgoCAzNnygoKCg
oCAxMy44NDZ8oKAgMTM4MzMuODQ2PGJyPgpSVER8oKCgoKAgMTMuODQ2fKCgoKAgMjAxLjg0Nnyg
oCAxNDA0NC45MjN8oKCgoKAgNDB8oKCgoKAgMTMuODQ2fKCgIDE0MDQ0LjkyMzxicj5SVER8oKCg
oKAgMTMuODQ2fKCgoKAgMjAxLjUzOHygoCAxNDA0NC4zMDd8oKCgoKAgNDR8oKCgoKAgMTMuODQ2
fKCgIDE0MDQ0LjkyMzxicj5SVER8oKCgoKAgMTMuODQ2fKCgoKAgMjAxLjUzOHygoCAxNDA0My4z
ODR8oKCgoKAgNDh8oKCgoKAgMTMuODQ2fKCgIDE0MDQ0LjkyMzxicj4KPGJyPlRoZXJlIGFyZSBv
dmVycnVuIGFuZCBtYXguIGxhdGVuY3kgaXMgdG8gaGlnaCAhIElzIHRoZXJlIHNvbWV0aGluZyB0
byBmaXggaXQuPGJyPjxicj5SdW5uaW5nIHdpdGggdGFza3Mgd2l0aCBtb3JlIHRoYW4gMTBtcyB0
aGVyZSBhcmUgb3ZlcnJ1biAsIGFuZCB0aGUgcmVzdWx0cyBsb29rcyBiZXR0ZXIgLi4uPGJyPjxi
cj5yb290QHZwYWMyNzA6L3Vzci94ZW5vbWFpL2JpbiQgLi9sYXRlbmN5IC1wIDEwMDAwPGJyPgo9
PSBTYW1wbGluZyBwZXJpb2Q6IDEwMDAwIHVzPGJyPj09IFRlc3QgbW9kZTogcGVyaW9kaWMgdXNl
ci1tb2RlIHRhc2s8YnI+PT0gQWxsIHJlc3VsdHMgaW4gbWljcm9zZWNvbmRzPGJyPndhcm1pbmcg
dXAuLi48YnI+UlRUfKAgMDA6MDA6MDGgIChwZXJpb2RpYyB1c2VyLW1vZGUgdGFzaywgMTAwMDAg
dXMgcGVyaW9kLCBwcmlvcml0eSA5OSk8YnI+UlRIfC0tLS0tbGF0IG1pbnwtLS0tLWxhdCBhdmd8
LS0tLS1sYXQgbWF4fC1vdmVycnVufC0tLS1sYXQgYmVzdHwtLS1sYXQgd29yc3Q8YnI+ClJURHyg
oKCgoCAxMy41Mzh8oKCgoKAgMTQuNzY5fKCgoKCgIDE5Ljk5OXygoKCgoKAgMHygoKCgoCAxMy41
Mzh8oKCgoKAgMTkuOTk5PGJyPlJURHygoKCgoCAxMy41Mzh8oKCgoKAgMTguNzY5fKCgoKCgIDgx
LjUzOHygoKCgoKAgMHygoKCgoCAxMy41Mzh8oKCgoKAgODEuNTM4PGJyPlJURHygoKCgoCAxMy4y
MzB8oKCgoKAgODUuODQ2fKCgoCA2ODMzLjUzOHygoKCgoKAgMHygoKCgoCAxMy4yMzB8oKCgIDY4
MzMuNTM4PGJyPgpSVER8oKCgoKAgMTMuNTM4fKCgoKCgIDg3LjA3NnygoKAgNjgwNy45OTl8oKCg
oKCgIDB8oKCgoKAgMTMuMjMwfKCgoCA2ODMzLjUzODxicj5SVER8oKCgoKAgMTMuMjMwfKCgoKCg
IDg1LjIzMHygoKAgNjgyNy45OTl8oKCgoKCgIDB8oKCgoKAgMTMuMjMwfKCgoCA2ODMzLjUzODxi
cj5SVER8oKCgoKAgMTMuNTM4fKCgoKCgIDg3LjM4NHygoKAgNjgwNC4zMDd8oKCgoKCgIDB8oKCg
oKAgMTMuMjMwfKCgoCA2ODMzLjUzODxicj4KUlREfKCgoKCgIDEzLjIzMHygoKCgoCA4NS44NDZ8
oKCgIDY4NDEuODQ2fKCgoKCgoCAwfKCgoKCgIDEzLjIzMHygoKAgNjg0MS44NDY8YnI+UlREfKCg
oKCgIDEzLjIzMHygoKCgoCA4Ny45OTl8oKCgIDY4MDEuNTM4fKCgoKCgoCAwfKCgoKCgIDEzLjIz
MHygoKAgNjg0MS44NDY8YnI+UlREfKCgoKCgIDEzLjIzMHygoKCgoCA4NC45MjN8oKCgIDY4MjAu
NjE1fKCgoKCgoCAwfKCgoKCgIDEzLjIzMHygoKAgNjg0MS44NDY8YnI+ClJURHygoKCgoCAxMy4y
MzB8oKCgoKAgODguNjE1fKCgoCA2Nzk1LjY5MnygoKCgoKAgMHygoKCgoCAxMy4yMzB8oKCgIDY4
NDEuODQ2PGJyPjxicj48YnI+PGJyPlRoYW5rcyAheDxicj48YnI+Cg==
--001485f19a0e0cfc2304731668d0--

