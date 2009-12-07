Message-ID: <20091207152135.5majgjfny8w4w04c@domain.hid>
Date: Mon, 07 Dec 2009 15:21:35 +0100
From: Wolfgang Mauerer <wm@domain.hid>
References: <4B1663B9.8030306@domain.hid>
	<4B166A5B.6030400@domain.hid> <4B166EFB.8050309@domain.hid>
	<4B16769A.9060700@domain.hid> <4B167A55.8080407@domain.hid>
	<4B167B4B.3010804@domain.hid> <4B167FC4.8080904@domain.hid>
	<4B1681DA.3090108@domain.hid> <4B1684D7.2080501@domain.hid>
	<4B1690EC.8030002@domain.hid> <4B16949B.2040806@domain.hid>
	<4B169CF7.2060108@domain.hid> <4B16D403.1070202@domain.hid>
	<4B16E417.3000400@domain.hid> <4B16E813.6050906@domain.hid>
	<36FCBE44-88E0-4AAA-9E83-1A9F9AB3F5D9@domain.hid>
	<4B17980A.3060503@domain.hid> <4B17B8E6.1060108@domain.hid>
	<4B17B9B1.3070606@domain.hid>
	<F41A4C16-8EF2-4B29-B79D-4549F0106D37@domain.hid>
	<4B17BF4E.7080509@domain.hid> <4B18201D.30003@domain.hid>
	<4B1830BD.7050804@domain.hid>
	<1260029489.2174.87.camel@domain.hid>
	<4B1CC76C.9030700@domain.hid> <4B1D066C.1030702@domain.hid>
	<1260194831.2370.10.camel@domain.hid>
In-Reply-To: <1260194831.2370.10.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Quoting Philippe Gerum <rpm@xenomai.org>:

> On Mon, 2009-12-07 at 14:43 +0100, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>> > Philippe Gerum wrote:
>> >> On Thu, 2009-12-03 at 22:42 +0100, Gilles Chanteperdrix wrote:
>> >>> Wolfgang Mauerer wrote:
>> >>>> Gilles Chanteperdrix wrote:
>> >>>>> Wolfgang Mauerer wrote:

>> We define a structure which will be shared between kernel and user,
>> which contains all data exported by kernel to user, as well as flags
>> indicating which member of the structure is available. The definition of
>> the struct for 2.5.0 will be:
>>
>> struct xnshared  {
>> =09unsigned long long features;
>> };
>>
>> This struct will be allocated in the global sem heap, and features will
>> be null for the time being.
>>
>> Every time we need to share some data between kernel and user (including
>> for the ntp support), we will add data to the structure, and use a
>> "features" bit to mean that the data are available from kernel. It will
>> work as long as we add data from release to release and never remove it.
>>
>> So, for 2.5.0, the xnshared structure will be allocated, but the
>> features member will be null. We will pass the offset of this structure
>> in the global sem heap in the sysinfo structure.
>>
>
> Go for this. Ack.

That's also fine for me.

Best, Wolfgang

