MIME-Version: 1.0
Date: Wed, 23 Mar 2011 11:24:15 +0800
Message-ID: <AANLkTinyoHF6tNGv5OvMEByYG1Eof8PSo9tnRO+_xEAd@domain.hid>
From: alamo hwuang <lovealamo@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd3acda3cf5bb049f1de5f1
Subject: [Xenomai-core] Help:Is the latency test right?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd3acda3cf5bb049f1de5f1
Content-Type: text/plain; charset=ISO-8859-1

Hi , I am using the xenomai to build the paltform and getting a latency test
results.

RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|     -2.407|     -2.185|      0.033|       0|     0|     -2.407|
0.033
RTD|     -2.356|     -2.179|      0.601|       0|     0|     -2.407|
0.601
RTD|     -2.355|     -2.185|     -0.165|       0|     0|     -2.407|
0.601
RTD|     -2.360|     -2.183|      0.041|       0|     0|     -2.407|
0.601
RTD|     -2.379|     -2.182|      0.080|       0|     0|     -2.407|
0.601
RTD|     -2.359|     -1.665|      2.635|       0|     0|     -2.407|
2.635
RTD|     -2.428|     -2.159|      1.516|       0|     0|     -2.428|
2.635
RTD|     -2.355|     -2.181|      0.139|       0|     0|     -2.428|
2.635
RTD|     -2.363|     -2.183|     -0.172|       0|     0|     -2.428|
2.635
RTD|     -2.361|     -2.180|     -0.060|       0|     0|     -2.428|
2.635
RTD|     -2.349|     -2.175|      0.108|       0|     0|     -2.428|
2.635
RTD|     -2.356|     -2.179|     -0.054|       0|     0|     -2.428|
2.635
RTD|     -2.353|     -2.163|      0.012|       0|     0|     -2.428|
2.635
RTD|     -2.354|     -2.164|      1.320|       0|     0|     -2.428|
2.635
RTD|     -2.386|     -1.491|      3.189|       0|     0|     -2.428|
3.189
RTD|     -2.351|     -2.003|      3.149|       0|     0|     -2.428|
3.189
RTD|     -2.407|     -2.166|      1.455|       0|     0|     -2.428|
3.189
RTD|     -2.360|     -2.146|      1.593|       0|     0|     -2.428|
3.189
RTD|     -2.426|     -2.169|      0.992|       0|     0|     -2.428|
3.189
RTD|     -2.362|     -2.179|      0.017|       0|     0|     -2.428|
3.189

How can I read the meaning of those results ?

and Are those results are correct???

what is the max size of  a xenomai task stack size?

Thansk for your information and help.

--000e0cd3acda3cf5bb049f1de5f1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SGkgLCBJIGFtIHVzaW5nIHRoZSB4ZW5vbWFpIHRvIGJ1aWxkIHRoZSBwYWx0Zm9ybSBhbmQgZ2V0
dGluZyBhIGxhdGVuY3kgdGVzdCByZXN1bHRzLiA8YnI+PGJyPlJUVHygIDAwOjAwOjAxoCAocGVy
aW9kaWMgdXNlci1tb2RlIHRhc2ssIDEwMCB1cyBwZXJpb2QsIHByaW9yaXR5IDk5KTxicj5SVEh8
LS0tLWxhdCBtaW58LS0tLWxhdCBhdmd8LS0tLWxhdCBtYXh8LW92ZXJydW58LS0tbXN3fC0tLWxh
dCBiZXN0fC0tbGF0IHdvcnN0PGJyPgpSVER8oKCgoCAtMi40MDd8oKCgoCAtMi4xODV8oKCgoKAg
MC4wMzN8oKCgoKCgIDB8oKCgoCAwfKCgoKAgLTIuNDA3fKCgoKCgIDAuMDMzPGJyPlJURHygoKCg
IC0yLjM1NnygoKCgIC0yLjE3OXygoKCgoCAwLjYwMXygoKCgoKAgMHygoKCgIDB8oKCgoCAtMi40
MDd8oKCgoKAgMC42MDE8YnI+UlREfKCgoKAgLTIuMzU1fKCgoKAgLTIuMTg1fKCgoKAgLTAuMTY1
fKCgoKCgoCAwfKCgoKAgMHygoKCgIC0yLjQwN3ygoKCgoCAwLjYwMTxicj4KUlREfKCgoKAgLTIu
MzYwfKCgoKAgLTIuMTgzfKCgoKCgIDAuMDQxfKCgoKCgoCAwfKCgoKAgMHygoKCgIC0yLjQwN3yg
oKCgoCAwLjYwMTxicj5SVER8oKCgoCAtMi4zNzl8oKCgoCAtMi4xODJ8oKCgoKAgMC4wODB8oKCg
oKCgIDB8oKCgoCAwfKCgoKAgLTIuNDA3fKCgoKCgIDAuNjAxPGJyPlJURHygoKCgIC0yLjM1OXyg
oKCgIC0xLjY2NXygoKCgoCAyLjYzNXygoKCgoKAgMHygoKCgIDB8oKCgoCAtMi40MDd8oKCgoKAg
Mi42MzU8YnI+ClJURHygoKCgIC0yLjQyOHygoKCgIC0yLjE1OXygoKCgoCAxLjUxNnygoKCgoKAg
MHygoKCgIDB8oKCgoCAtMi40Mjh8oKCgoKAgMi42MzU8YnI+UlREfKCgoKAgLTIuMzU1fKCgoKAg
LTIuMTgxfKCgoKCgIDAuMTM5fKCgoKCgoCAwfKCgoKAgMHygoKCgIC0yLjQyOHygoKCgoCAyLjYz
NTxicj5SVER8oKCgoCAtMi4zNjN8oKCgoCAtMi4xODN8oKCgoCAtMC4xNzJ8oKCgoKCgIDB8oKCg
oCAwfKCgoKAgLTIuNDI4fKCgoKCgIDIuNjM1PGJyPgpSVER8oKCgoCAtMi4zNjF8oKCgoCAtMi4x
ODB8oKCgoCAtMC4wNjB8oKCgoKCgIDB8oKCgoCAwfKCgoKAgLTIuNDI4fKCgoKCgIDIuNjM1PGJy
PlJURHygoKCgIC0yLjM0OXygoKCgIC0yLjE3NXygoKCgoCAwLjEwOHygoKCgoKAgMHygoKCgIDB8
oKCgoCAtMi40Mjh8oKCgoKAgMi42MzU8YnI+UlREfKCgoKAgLTIuMzU2fKCgoKAgLTIuMTc5fKCg
oKAgLTAuMDU0fKCgoKCgoCAwfKCgoKAgMHygoKCgIC0yLjQyOHygoKCgoCAyLjYzNTxicj4KUlRE
fKCgoKAgLTIuMzUzfKCgoKAgLTIuMTYzfKCgoKCgIDAuMDEyfKCgoKCgoCAwfKCgoKAgMHygoKCg
IC0yLjQyOHygoKCgoCAyLjYzNTxicj5SVER8oKCgoCAtMi4zNTR8oKCgoCAtMi4xNjR8oKCgoKAg
MS4zMjB8oKCgoKCgIDB8oKCgoCAwfKCgoKAgLTIuNDI4fKCgoKCgIDIuNjM1PGJyPlJURHygoKCg
IC0yLjM4NnygoKCgIC0xLjQ5MXygoKCgoCAzLjE4OXygoKCgoKAgMHygoKCgIDB8oKCgoCAtMi40
Mjh8oKCgoKAgMy4xODk8YnI+ClJURHygoKCgIC0yLjM1MXygoKCgIC0yLjAwM3ygoKCgoCAzLjE0
OXygoKCgoKAgMHygoKCgIDB8oKCgoCAtMi40Mjh8oKCgoKAgMy4xODk8YnI+UlREfKCgoKAgLTIu
NDA3fKCgoKAgLTIuMTY2fKCgoKCgIDEuNDU1fKCgoKCgoCAwfKCgoKAgMHygoKCgIC0yLjQyOHyg
oKCgoCAzLjE4OTxicj5SVER8oKCgoCAtMi4zNjB8oKCgoCAtMi4xNDZ8oKCgoKAgMS41OTN8oKCg
oKCgIDB8oKCgoCAwfKCgoKAgLTIuNDI4fKCgoKCgIDMuMTg5PGJyPgpSVER8oKCgoCAtMi40MjZ8
oKCgoCAtMi4xNjl8oKCgoKAgMC45OTJ8oKCgoKCgIDB8oKCgoCAwfKCgoKAgLTIuNDI4fKCgoKCg
IDMuMTg5PGJyPlJURHygoKCgIC0yLjM2MnygoKCgIC0yLjE3OXygoKCgoCAwLjAxN3ygoKCgoKAg
MHygoKCgIDB8oKCgoCAtMi40Mjh8oKCgoKAgMy4xODk8YnI+PGJyIHN0eWxlPSJjb2xvcjogcmdi
KDI1NSwgMCwgMCk7Ij48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigyNTUsIDAsIDApOyI+SG93IGNh
biBJIHJlYWQgdGhlIG1lYW5pbmcgb2YgdGhvc2UgcmVzdWx0cyA/PC9zcGFuPjxiciBzdHlsZT0i
Y29sb3I6IHJnYigyNTUsIDAsIDApOyI+CjxiciBzdHlsZT0iY29sb3I6IHJnYigyNTUsIDAsIDAp
OyI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjU1LCAwLCAwKTsiPmFuZCBBcmUgdGhvc2UgcmVz
dWx0cyBhcmUgY29ycmVjdD8/Pzwvc3Bhbj48YnI+PGJyPndoYXQgaXMgdGhlIG1heCBzaXplIG9m
oCBhIHhlbm9tYWkgdGFzayBzdGFjayBzaXplPzxicj48YnI+VGhhbnNrIGZvciB5b3VyIGluZm9y
bWF0aW9uIGFuZCBoZWxwLjxicj4KPGJyPgo=
--000e0cd3acda3cf5bb049f1de5f1--

