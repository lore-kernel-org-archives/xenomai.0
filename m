Message-ID: <50851EF6.7010103@siemens.com>
Date: Mon, 22 Oct 2012 12:24:54 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50843CB3.6040406@uqconnect.edu.au> <5084F364.20404@grandegger.com>
In-Reply-To: <5084F364.20404@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Drivers for 4-channel CAN or EtherCAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org

On 2012-10-22 09:19, Wolfgang Grandegger wrote:
> On 10/21/2012 08:19 PM, David Butterworth wrote:
>> Hi all,
>>
>> Is anyone working on drivers for a 4-channel CAN card?  and what
>> EtherCAT drivers are currently available?
> 
> I never heard of EtherCAT with CAN? It normally uses Ethernet network
> devices. Or have I missed something?

IIRC, there is CANopen over EtherCAT. But that doesn't mean a raw CAN
interface is provided by an EtherCAT stack.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

