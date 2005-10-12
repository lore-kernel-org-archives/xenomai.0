Message-ID: <434D2CCD.4070802@domain.hid>
Date: Wed, 12 Oct 2005 17:33:33 +0200
From: Luotao Fu <devtty0@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090009080603070302070208"
Subject: [Xenomai-help] Kernel oops on posix threads
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

This is a multi-part message in MIME format.
--------------090009080603070302070208
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi folks,

I found out that parallel threads using the Posix skin cause kernel oops
somewhere between the finishing of the threads and the main thread. I
have two threads, say thread A and thread B. Both created as joinable
threads and they have both the same priority 99. The main routine hold a
semaphore semA to synchronize the threads. After the creation thread A
waits on the Semaphore semA, while the thread B runs and releases semA,
so that semA can finish. On exiting the thread B I always get a Kernel
ooops. The kernerl says:

unable to handle kernel paging request at virtual address 6b6b6b77
etc.......

I scratched some simple code which causes this Kernel Ooops. Packed a
tar ball together with the makefile and attached the tar ball it to this
mail so that you might have a look at it yourself.
I'm using
Kernel: Vanilla 2.6.12 patched with adeos-linux-2.6.12-i386-r12.patch
Distr. Debian 3.1
Testhost: vmware 5.0
compiler gcc 3.3.5

I also wrote some code doing the same tasks in RTAI native context and
it ran without problems. Hence I suppose the problem to be in the posix
skin.
Am I making any mistakes in the code or have I evtl. found a bug in the
posix skin?

Cheers
Luotao Fu

--------------090009080603070302070208
Content-Type: application/gzip;
 name="test_posix.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="test_posix.tar.gz"

H4sIALsqTUMAA+1XbW+jRhD2V/gV05wTQQ4n4NiJLo5PJY59ceW8yHGkk9rIIssS7x0Gd4Fc
rDT/vbO8BOy8qr1cW5XnA7CzM7szz8wOENIgHM/8gN1sVt4KOmKn2RR3Y6epF+8ZKoa+Vd+q
15v17e2KbjQMQ69A8808KiAKQosDVNzIDy3/ab2X5rNAsvt/BGGef/G4Qd5gD8HHdqPxVP4b
+raR5b/R2DEw/836llGBH0Li/zz/8jvmETeyKewFoc38jcnHBRFn3tWyzHbZ5aJsFk44tewH
isvrUc69JZHLpiwMliznweZ0anlLUjq1ZhOfUyGW39nUYR6F0eFwbB6dnB+PoC7LmMyQEUDV
cSiuZkuWr31mwzq5GUZeL/KIqSSCmcWn6q0szTDE0FFWkhDABFEQIbV/81bUliwhBRHBtciE
2mO0saaQXNtwCxupmDOfs3COsg8f4K4lQ4qUl3FAw1gztlRyqesoqnbWOewejHv93om2Fiuo
+QLfJsyloIh4vlksVNZETCq021AzYG0NYkLFsNs/Hg1VWZJaeUQmIEMsmKSxSDiT7kxvcK3j
88FASO8eULT/PEX7/wqKJEEKdq6MlELg+68OHPVhajFPEQ8WvyIakAn2g/V1HFyr8i3aiini
a5wUF0KRYGsUj37Ni/CiletYYchREUcmPgnrv8SUxBxQpq5Pvlquqxx1BuPO+XDYxYL/A8So
dz46H3bTolAB8yXNsC58rqwQP3Jt8PwQhDlM6ZT6fJ6mTYrJMMTjXbJJ4kCWicilXNE1KJAP
KfvP74ULwFm2wuJWUr4XZg+TlGZP0zVdVYvLZfMF++7n/mjcM/sDEW5eQXfSEuXJsint6nJC
0DubhhaZiF5B7/W0U0xi1zwYd/A66o5/Oekfm/uD7mP2zJtQTFHM0sMFup9PB/0OuhoTt1B+
2QJJpfsuI/PcPudZbcFTNvHpuDfJD4OgFBROsGoyQ4JXEWCxUPUL7d4Y8paoQXwmsH/EjP7U
Bh1ENjKKnfRkYUvH9GiwQixPZDrZApLFA1gNsLQ07A48SSInKoYvPVZqr/DVeNTX/cxX+NvO
vsJVx+foK8EWC3pL3PcKLxwheP8+OQVxTFk0X3zsKMVQiH+Rup27Wzg5iX/CKvNOdK3Ym4I7
wp/7FieU7xtwyuk08rIukZ3Q4onKp8GxmBtx+kgbEMfOxg9B7s/zvsppGHEPGcCW+U9/sJT4
rih8/x9ZX/GTyqXffY8Xvv/1bfw3zP7/jLr4/2s2m+X3/w/BjGPOb2C3DVUFP5iwN/DQYjXi
ew67glotmVdl5tDfQakq6VhT5aoS9xU4dakVULBsG/ZiW+Yhpa5bm1nh5OPmJTa10Ie5H6Gq
OTqEa4sz69Klqkw9mzny2Qjfub2B+ekMnnFDVGiNOK51FaixyeAgsXnBxLUTG6i5Yjo2HZnD
T91RbCrKH38a7F1cpDClyhjALr4dbHlRvqS3u9pe3SD42qwqnQ7u4UP1Z6jupUpJVGo6Sh1W
ZYKEebvCZniENg6sb/iwPg7wuriZGPaPcp/K3luiRIkSJUqUKFGiRIkSJUqUKFGiRIkSJV6L
PwGhOv2CACgAAA==
--------------090009080603070302070208--

