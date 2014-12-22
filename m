Message-ID: <549831F3.8070701@xenomai.org>
Date: Mon, 22 Dec 2014 16:00:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca> <5488A2BD.3080800@xenomai.org>
 <20141210194405.GH24110@csclub.uwaterloo.ca> <5488A985.2070006@xenomai.org>
 <5497ED3D.9010304@web.de> <5497FE33.30007@xenomai.org>
 <20141222144612.GJ24110@csclub.uwaterloo.ca>
In-Reply-To: <20141222144612.GJ24110@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __ipipe_root_status exported GPL only but used to be
 not GPL only and is breaking other code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org

On 12/22/2014 03:46 PM, Lennart Sorensen wrote:
> On Mon, Dec 22, 2014 at 12:19:15PM +0100, Philippe Gerum wrote:
>> On 12/22/2014 11:06 AM, Jan Kiszka wrote:
>>> Lennart, are you on x86 and do you have CONFIG_CMP disabled? Then
>>> __ipipe_root_status gets pulled in via arch_local_irq_disable ->
>>> ipipe_stall_root. If that is the problem, I think it's more than
>>> reasonable to argue that effectively making local_irq_disable GPL-only
>>> would be an unwanted restriction over mainline.
>>>
>>
>> This has been agreed upon.
> 
> Will the change go in git sometime so I can pull it from there.  I could
> change it locally (and did to test it), but would much rather pull the
> code cange from the git tree.
> 

I'll push the change to the git tree.

-- 
Philippe.

