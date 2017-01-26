From: =?iso-8859-1?Q?Lassi_Niemist=F6?= <lassi.niemisto@wapice.com>
Date: Thu, 26 Jan 2017 10:12:40 +0000
Message-ID: <dc106047074e4f73b89c1b3a7a3b7069@EDB3.wapice.localdomain>
References: <b9af993a-5dcd-396f-e6c0-31a13efeb909@numalliance.com>
In-Reply-To: <b9af993a-5dcd-396f-e6c0-31a13efeb909@numalliance.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] shared heap access mixing 32 and 64 bits applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?iso-8859-1?Q?St=E9phane_Ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> Is it possible to access same shared memory heaps , between 32 and 64 bit=
s processes ?

In regular linux I faced the wall when trying to protect the usage of the s=
hared memory area by (pthread iirc) mutex/semaphore - those structures had =
differences between 32/64bit platforms. I don't know if situation is same i=
n Xenomai but pay attention also to what you are going to put in the shared=
 memory.

-Lassi

