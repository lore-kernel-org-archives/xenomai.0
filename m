Date: Tue, 12 Feb 2019 18:46:49 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: Help on porting lwIP to Xenomai (Beaglebone Black, AM335X)
Message-ID: <20190212184649.768b2e1f@md1za8fc.ad001.siemens.net>
In-Reply-To: <8820d79c-1b53-f663-ab1a-874211e54ecf@siemens.com>
References: <acee54530584479b865ccefdbe3b0913@stud.uni-stuttgart.de>
 <8820d79c-1b53-f663-ab1a-874211e54ecf@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka via Xenomai <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Baur, Elias" <st153286@stud.uni-stuttgart.de>

On Tue, 29 Jan 2019 15:40:35 +0100
Jan Kiszka via Xenomai <xenomai@xenomai.org> wrote:

> On 29.01.19 10:57, Baur, Elias via Xenomai wrote:
> > Hello everyone,
> > 
> > I am new to lwIP and did a lot of research the last couple of days.
> > My goal ist to do real time networking between wire-connected
> > Beagleboards. Therefore, we have been setting up a Xenomai
> > Co-Kernel on the boards. To actually send and receive UDP-packets,
> > we want to use lwIP instead of RTnet, because we are already using
> > it on other boards.  
> 
> This doesn't sound like a strong argument. You should better look for
> hard facts, what benefits (or downsides) an lwIP stack would have.
> Then it is more realistic to weigh estimated efforts on both sides
> against benefits.

Well the background might be more academic, so i would not be too fast
to judge. If my guess is correct we might be talking about some sort of
student assignment, Masterarbeit, Beleg etc. Knowing the scope, maybe
be can come up with an improved assignment together.

Henning 

> Also, who should be the low-level driver provider in your lwIP setup?
> Do you plan to write one from scratch?
> 
> Jan
> 
> > 
> > I have found out that TI has already ported lwIP on its CPU in its
> > Starterware:
> > http://processors.wiki.ti.com/index.php/StarterWare_CPSW_Port_lwIP
> > Now I am wondering whether it is possible to adapt this for
> > Xenomai? Does anyone have experience on that?
> > 
> > Thank you very much!
> > Best, Eloa
> >   
> 


