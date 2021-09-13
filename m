Subject: Re: Mercury 32bit VxWorks skin
References: <CAE5ycSt1dKfcZs=NPLszW6Jqr_5kk2YGMZ1ggfUEj=NJ99BLCw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <713f0ce8-5df2-400d-7ffe-2e9cbb0f86dc@siemens.com>
Date: Mon, 13 Sep 2021 15:50:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAE5ycSt1dKfcZs=NPLszW6Jqr_5kk2YGMZ1ggfUEj=NJ99BLCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Enrico Buffoli <enrico.buffoli1994@gmail.com>, xenomai@xenomai.org

On 13.09.21 15:21, Enrico Buffoli via Xenomai wrote:
> Hello,
> 
> I've a question regarding the execution of the Mercury 32bit VxWorks skin
> on an 64 bit patch rt Linux 4.14.78-rt47 on aarch64.
> Is this setup possible? or there are some known issues/limits?
> 

We have no recent feedback on the usage of Mercury. Right now, no one is
working on its QA. Conceptually, this may work, but we can't tell
upfront if there will be issues.

In addition, all porting of VxWorks apps always involve the untangling
of drivers from the application code. Only the latter is covered by the
skin, the former often requires architectural porting to Linux.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

