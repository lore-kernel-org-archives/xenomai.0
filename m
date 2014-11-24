Message-ID: <5473636E.6030206@xenomai.org>
Date: Mon, 24 Nov 2014 11:57:18 -0500
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfZm+F3M+VtD2zG=JMun1GYtNDOAbzYvVUDXxq5B8qsMw@mail.gmail.com>	<53F30622.4050605@xenomai.org>
 <CAKKWdtfjaZcjX0q0W0kJQSeJiNCssYE21hrbzR4PseXr1MOzfw@mail.gmail.com>
In-Reply-To: <CAKKWdtfjaZcjX0q0W0kJQSeJiNCssYE21hrbzR4PseXr1MOzfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  a question about interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/24/2014 11:38 AM, ali hagigat wrote:
> Please answer the following questions. I am much appreciated.
> 
> 1) does ISR(interrupt service routine) have priority over the Xenomai
> real-time tasks? any ISR defined for root or head domain? are executed
> in the middle of the real-time tasks?
> 
> 2) if there is a linux thread and a regular interrupt happens and then
> a timer interrupt happnes, means , xnintr_clock_handler(), the
> xnpod_schedule() function will suspend the linux thread? and the linux
> thread is suspended with two nested interrupt?
> 
> I wonder if you could answer yourself, mailing list is escaping from
> answering these questions. thank you
> 


hi Ali,

Let me share this with the mailing list.
I am sure these questions can be resolved in the open - actually I think Gilles
might have already addressed them.

cheers,


- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUc2NuAAoJECDcy2IJkagR7RAH/34zgxJkOcvjrmU2uQNfhjUC
rFpY8WlY0hSAs4XrAx9uHN5P6PntcWG61NGkH1dPq73AhGjnIl3pyW7Iv5/Mh58H
Py5NyvCx6VfGCO5DrnJ3yhTil61Pzgh++W0lVf32hrpUvhyaYoaYkLWSwK5L+Qr2
YYrKG4UhceJpAOJzEvgblxXlq/oNn6wwYE8kCsHUurYAPs4VKzMQe83pkz8m6ReY
wXcQ1hKC3lNKE8htEp/5KHpSV+sR/dkCH98bBXaQELlU7GIhvflM6ZuZ593zx36u
m/RzOQGmlgnvoleL3mIwDMKXjWAYAKk5R4JogSdlzt+DX9a84VFN+6lCqpgkDrs=
=GA0y
-----END PGP SIGNATURE-----

