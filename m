From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 21 Dec 2015 21:43:04 -0500
Message-ID: <20151222024304.GR25177@csclub.uwaterloo.ca>
References: <CADYNH7X5DJ5WTOfNYfVgoVw8o0cmF8Johhef=zakncwLqHoMQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYNH7X5DJ5WTOfNYfVgoVw8o0cmF8Johhef=zakncwLqHoMQw@mail.gmail.com>
Subject: Re: [Xenomai] NVIDIA Drivers w/ Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Eric Huang <ehuang@gatech.edu>
Cc: xenomai@xenomai.org

On Mon, Dec 21, 2015 at 07:22:26PM -0500, Eric Huang wrote:
> The specific question I am trying to answer is whether it is possible (at
> all) to install an NVIDIA driver alongside Xenomai
> 
> My system is the following.
> 
> uname -a
> Linux robot-Z68X-UD3H-B3 3.2.21-xenomai-2.6.1 #1 SMP Thu Jul 26 11:46:23
> EDT 2012 x86_64 x86_64 x86_64 GNU/Linux
> 
> xeno-config --version
> 2.5.5.2

Wow that is really really old.

> For more details, my application is a real-time controller which needs to
> do image processing on a GPU. The image processing code executes at 500ms
> on a CPU and 15ms on a GPU. The image frame rate is 30hz. The control loop
> frequency is 500hz. The control loop is the only part which needs to be
> hard RT.
> 
> If I can't install and run the NVIDIA driver at all on my system I will
> look into a solution with a separate control and perception computer.

Since xenomai uses ipipe which changes the way IRQs are handled, the
fact you don't have source code to recompile the nvidia driver means you
can make the nvidia driver work correctly with ipipe, so if you have the
nvidia driver running you really have no idea if you will get real time
or not since the nvidia driver won't be following the rules.

At least that is how I have understood the situation.

-- 
Len Sorensen

