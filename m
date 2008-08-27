Message-ID: <48B57046.70207@domain.hid>
Date: Wed, 27 Aug 2008 17:18:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B5592B.1090005@domain.hid> <48B55F7C.5030901@domain.hid>
	<48B56685.4060500@domain.hid> <48B56876.3090601@domain.hid>
	<48B568FD.9010905@domain.hid> <48B56A0C.9060006@domain.hid>
	<48B56AF6.6080509@domain.hid> <48B56C06.1030808@domain.hid>
	<48B56D05.6020509@domain.hid> <48B56E69.9000100@domain.hid>
	<48B56F78.6050405@domain.hid>
In-Reply-To: <48B56F78.6050405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH 2/3] Switch to handle-based fast
	mutex owners
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> File descriptors are all identically structured objects, so at worst you
>> ruin some other app's day. But the registry contains arbitrary objects
>> with different internal layout. If you start assuming object_a * is
>> object_b * and use the pointer etc. included in a as if they have the
>> meaning of b, you quickly ruin the kernel's day as well. Therefore,
>> native, e.g., does magic checks after fetching from the registry. As I
>> said, this test here works differently, but it has the same effect and
>> impact.
> 
> By the way, would not it make sense to have separate hash tables for
> separate objects types ? I mean then we would not need any validation,
> and several object types could use the same name.

>From that POV a good idea. The only issue I see is a management problem:
How many mutex, thread, queue, whatever slots do you want in your
system? One knob for them all? Or countless knobs for all object types
of all skins? That's hairy, I'm afraid.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

