Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: mathew.benson@gmail.com
In-Reply-To: <20170725190214.6f2fd892@md1em3qc>
Date: Wed, 26 Jul 2017 09:42:28 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0F23933-FC14-43CE-BC99-96B60FCE241B@gmail.com>
References: <DEB5F512-B818-454D-A423-7CB391071BBD@gmail.com>
 <20170725190214.6f2fd892@md1em3qc>
Subject: Re: [Xenomai] rt_task_create fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: xenomai@xenomai.org

I didn't create a shadow yet.  None of the sample code I found did that.  Is=
 that required?

Sent from my iPhone

> On Jul 25, 2017, at 12:02 PM, Henning Schild <henning.schild@siemens.com> w=
rote:
>=20
> Am Tue, 25 Jul 2017 07:48:46 -0500
> schrieb <mathew.benson@gmail.com>:
>=20
>> I ported Xenomai 3.0.5 to Petalinux 2017.1.  The supported tests run
>> fine, but my code is failing.  rt_task_create always fails with errno
>> set to 17 (EEXIST).  Doesn't matter what arguments I give it.  Before
>> I dissect this further, does anybody have any insight?
>=20
> Your thread might not have a shadow yet and you might see a case where
> an EPERM is transformed into an EEXIST.
> We did not discuss the transformation bug yet. But your solution might
> be to just shadow on EPERM and EEXIST, or before calling anything that
> needs a shadow.
>=20
> http://www.xenomai.org/pipermail/xenomai/2017-July/037474.html
>=20
> Henning
>=20
>> Sent from my iPhone
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>=20

