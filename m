Subject: Re: Xenomai crashes when braking into the debugger
References: <DB8PR05MB59152BC02ED36C78202DB8AEF6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <523b765a-27b2-480b-375f-0fdfb9af5f8e@siemens.com>
Date: Wed, 13 Nov 2019 18:41:56 +0100
MIME-Version: 1.0
In-Reply-To: <DB8PR05MB59152BC02ED36C78202DB8AEF6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 13.11.19 16:18, Lange Norbert via Xenomai wrote:
> Hello,
> 
> I am running into some bad issues with debugging,
> can't really narrow down when they happen, but usually when I run through GDB and want to "break" (pause execution),
> it seems to be related to *other* Xenomai programs running at the same time (as said its hard to narrow down).

We have a gdb test case. Does it trigger for you as well when you run 
some other program in parallel?

Also, could you provide the kernel full log? Possibly, enabling the 
I-pipe tracer with panic dump could be useful as well. But the most 
important step would be to create reproducibility for a third party like me.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

