Subject: Re: interrupt type from user mode
References: <OFB0192583.FFDDFA25-ONC125837E.00397C29-C125837E.003A1D77@notes.ce.collabserv.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cc1cdb41-6cbf-2e46-5a9c-de7db8a566b7@siemens.com>
Date: Fri, 11 Jan 2019 10:30:03 +0800
MIME-Version: 1.0
In-Reply-To: <OFB0192583.FFDDFA25-ONC125837E.00397C29-C125837E.003A1D77@notes.ce.collabserv.com>
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
To: Stefano Franzoni <stefano.franzoni@marposs.com>, xenomai@xenomai.org

On 10.01.19 18:34, Stefano Franzoni via Xenomai wrote:
> Dear experts
> 
> I have to make changes to a project developed years ago with arm
> architecture (atmel AT91SAM9G20) with linux 2.6.30 and xenomai 2.5.4.
> 
> The program uses a xenomai application in user mode and is connected to an
> interrupt (IRQ0).
> 
> I should reprogram the interrupt controller to receive interrupt on the
> rising edge, but I did not understand if this is possible from Xenomai
> user mode.
> I know that I should develop an RTDM project but I'm trying to reuse a
> code already written that was entirely in user mode.
> 

That old Xenomai used to have the native intr API for user space - maybe worth 
to have a look if that already helps.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

