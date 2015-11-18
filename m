MIME-Version: 1.0
Message-ID: <trinity-01df658a-55a1-411b-8a50-0219f2706320-1447862594993@3capp-webde-bap53>
From: JK.Behnke@web.de
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2015 17:03:15 +0100
In-Reply-To: <CAPRPZsDn9AFciNrBESG8Tn8oWwEeQ78Hzrnd0E0rknrjY1C+WQ@mail.gmail.com>
References: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
 <20151118135249.GA24942@hermes.click-hack.org>,
 <CAPRPZsDn9AFciNrBESG8Tn8oWwEeQ78Hzrnd0E0rknrjY1C+WQ@mail.gmail.com>
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: xenomai@xenomai.org

Hello Jeroen,

>>>
>>> Is that realistic?
>>
>> This seems to be a lot.
>
>It looks quite long, yes, for what should essentially be an RDTSC instruction.
>
>Why not test without the sleep and compare two back-to-back
>rtdm_clock_read()s to make sure that you're not measuring jitter from
>the sleep function ?
OK, I removed the sleep.
On Atom E640 (1.0 GHz) I get min=70 ns, max=91 ns, avg=79 ns
On Atom E660 (1.3 GHz) I get min=50 ns, max=71 ns, avg=62 ns

Regards
Jochen

