Message-ID: <5281EA5E.8060806@xenomai.org>
Date: Tue, 12 Nov 2013 09:44:14 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <005d01cedbb9$e2a83430$a7f89c90$@laurens@safire.fr>
In-Reply-To: <005d01cedbb9$e2a83430$a7f89c90$@laurens@safire.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Atom N455
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc LAURENS <marc.laurens@safire.fr>, xenomai@xenomai.org

On 11/07/2013 02:04 PM, Marc LAURENS wrote:
> Hello,
>
>
>
> Can you tell me if the N455 Atom processor is supported by Xenomai ? I plan
> to buy the adlink 745 CoreModule CPU Board.
>

As for any real-time linux variant/implementation over x86, the only 
showstopper might be the massive latency spots induced by SMI handlers. 
Since this is a BIOS-originated problem, testing is required before 
buying. However, there is hope with automation-oriented hardware. 
SMM/SMI most commonly plagues x86 laptops/desktops.

-- 
Philippe.

