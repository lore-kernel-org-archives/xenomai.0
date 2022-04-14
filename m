Message-ID: <4dc772a8-a120-df8e-41d5-6fa305c2ad80@siemens.com>
Date: Thu, 14 Apr 2022 17:43:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/9] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
References: <20220413215819.22954-1-richard@nod.at>
 <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
 <1588685029.254441.1649949221432.JavaMail.zimbra@nod.at>
 <791b80dc-363a-219a-d245-cde9e9905b27@siemens.com>
 <1221659663.254503.1649950864066.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1221659663.254503.1649950864066.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@xenomai.org>

On 14.04.22 17:41, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>>> Did the nucleus CPU scheduler guarantee that giving another task
>>> the same priority of the calling task will favour the caller?
>>> Now the gifted task seems to win.
>>
>> Did you configure with --enable-lazy-setsched? If not, set_prio should
>> send the caller to Linux, and that will definitely cause some scheduling
>> change.
> 
> Yes. -enable-lazy-setsched is set.
> 

Then it's better to trace than to speculate.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

