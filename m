From: Markus Valtin <valtin@control.tu-berlin.de>
Date: Mon, 03 Sep 2012 16:58:12 +0200
Message-ID: <26407900.QVKJ8GonV5@valtin-rt>
In-Reply-To: <50449CEC.6060900@evidence.eu.com>
References: <2211797.6MhXv49D68@valtin-rt> <50436D2A.2070607@xenomai.org>
	<50449CEC.6060900@evidence.eu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] Scicos/Xcos Code Generation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: xenomai@xenomai.org

Am Montag, 3. September 2012, 14:05:00 schrieben Sie:
> Il 02/09/2012 16:28, Gilles Chanteperdrix ha scritto:
> > On 08/22/2012 06:28 PM, Markus Valtin wrote:
.....
> > 
> > This code generator does not use the RTAI skin, but the POSIX skin.
> 
> Hello everybody.
> 
> I'm Claudio, the author of the original email.

Hello, great to hear from you.

> As you have seen, our web page allows to download the ScicosPack, which
> works with the Xenomai POSIX skin.

Yes I did that, but haven't had time to try it out yet.

> Actually, during the last years, we have not maintained such software,
> mainly due to the lack of feedback or specific requests from
> universities or companies. For some recent project based on the x86
> platform we have used RTAI + Scicos + Comedi. On our embedded platforms,
> instead, we usually prefer Xenomai, but we didn't have any request for
> code generation, yet.

We also use a RTAI + Scicos + Comedi combination for your projects but for new 
projects we are looking for more up to date solutions, preferably with the 
same comfort RTAI / RTAI Lab and xrtailab / qrtailab offers.

> @Markus: can you please give me more details about what you are looking
> for ?
Sure.

As I said we  mainly use  RTAI + RTAI Lab + Scicos (Scilab 4.1.2) for 
experiments where higher update frequencies are required  or where jitter  is 
not acceptable.
Examples are:

Teaching
 * Inverted Pendulum
     http://www.control.tu-berlin.de/File:PR_Grundlagen_Pendel.jpg
 * Magnetic Levitation

Research
 * Active Vibration Control 
    http://www.control.tu-
berlin.de/Active_Vibration_Control_of_a_Light_and_Flexible_Stress_Ribbon_Footbridge_using_Pneumatic_Muscles
  * Various FES (Functional Electrical Stimulation) based  projects
     http://www.control.tu-
berlin.de/Controlled_Functional_Electric_Stimulation_for_Rehabilitation_Purposes

We use the HART Toolbox (hart.sf.net) and own C/C++ functions to interface 
with various external devices (mostly USB / FTDI) (Linux Kernel driver based).

We appreciate the rapid prototyping with Scicos and the ability to change the 
variouse block parameters on the fly with xrtailab / qrtailab. (RTnet based 
interface to RTAILAB).

However we like to be able to use Scilab 5 and newer kernel versions.
We also would love the possibility to cross compile your Scicos based code for 
lets say the the beagle bone and control  this software from another PC.

> If I've understood, you work at the university. Indeed, we are a
> spin-off company of the university (Scuola Sant'Anna, Pisa, Italy) and
> we are very interested in continuing our relationship with research
> institutions.

This should be possible, as long as the result is Open Source and we can 
modify the code to our needs.

> 
> Best regards,
> 
> 	Claudio

Sincerely 
  Markus Valtin

