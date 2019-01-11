Subject: Re: interrupt type from user mode
References: <OFB0192583.FFDDFA25-ONC125837E.00397C29-C125837E.003A1D77@notes.ce.collabserv.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <dca9a521-5a8e-ca7b-d129-3b07c7bea030@xenomai.org>
Date: Fri, 11 Jan 2019 11:45:07 +0100
MIME-Version: 1.0
In-Reply-To: <OFB0192583.FFDDFA25-ONC125837E.00397C29-C125837E.003A1D77@notes.ce.collabserv.com>
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
To: Stefano Franzoni <stefano.franzoni@marposs.com>, xenomai@xenomai.org

On 1/10/19 11:34 AM, Stefano Franzoni via Xenomai wrote:
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

Unfortunately, there won't be any other option than adding the required
setup bits via some code living in kernel space. There is no userland
API exposing interrupt types in 2.5.4, you could control masking only.

-- 
Philippe.

