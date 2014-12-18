Message-ID: <5492989C.9070106@siemens.com>
Date: Thu, 18 Dec 2014 10:04:28 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAMJ=MEdh-vBm1S9cHL7Hj0Ky-RaeGCSw_xauMZoEsuegbArM1w@mail.gmail.com>
 <CAMJ=MEfDQm_ymyL8FULhqMvpwzet4aHMbQFoEjL-sVDsCTg2Hg@mail.gmail.com>
 <549072DC.1030901@xenomai.org>
 <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
 <549090FA.7000901@xenomai.org>
 <CAMJ=MEc9UXa4P18kNmPeKH-SziXMj9Grbxagj7Wm_MckHcOC7Q@mail.gmail.com>
In-Reply-To: <CAMJ=MEc9UXa4P18kNmPeKH-SziXMj9Grbxagj7Wm_MckHcOC7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2014-12-18 09:00, Ronny Meeus wrote:
>>
>> A release of the glibc that fixes this issue. I must admit that I did
>> not track this problem lately. Jan likely knows better here.
>>
> 
> Jan,
> 
> what version glibc solves the priority inversion issue on conditional variables?
> I already tried the glibc 2.18 but the issue is still there.

The bug is still not fixed, and discussion stalled again, see
https://sourceware.org/bugzilla/show_bug.cgi?id=11588

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

