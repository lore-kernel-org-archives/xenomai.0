Message-ID: <54C64338.8050904@grinta.net>
Date: Mon, 26 Jan 2015 14:38:00 +0100
From: Daniele Nicolodi <daniele@grinta.net>
MIME-Version: 1.0
References: <129277905.Ag2XebZWbK@soho> <8367559.zdLagntR1r@indiana>
 <20150126120824.GF12812@hermes.click-hack.org> <2052908.cWhQn5Pgch@soho>
In-Reply-To: <2052908.cWhQn5Pgch@soho>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Leopold,

it seems to me that you are missing a few key points.

On 26/01/15 13:39, Leopold Palomo-Avellaneda wrote:
>> This is a decision that upstream should not impose to all users.
> 
> Interesting sentence. You are developing a new version with an step forward. 
> You have reworked libraries and for instance libxenomai, libnative, librtdm 
> doesn't exists in Xenomai-3. Also you have introduced new ones (libalchemy, 
> libcobalt, libcopperplate, libtrank. 
> 
> You have developed xenomai in two main group of libraries (or use a cobalt 
> kernel or a mercury kernel) and are you saying that you cannot impose to all 
> users a suffix or something that the users could have both version co-
> installed in standards places in their systems?

The APIs provided by Xenomai on top of the regular Linux kernel
interface are only for smoothing the porting of legacy application
written using the APIs peculiar to other RTOS and which Xenomai implements.

Ideally any new development should be done with the POSIX APIs.

The choice between cobalt or mercury is demanded by the real time
requirements of the specific application and the target hardware. It
cannot be a user configuration.

>> Only users with your specific needs should do what you want. 
> 
> Maybe I'm wrong. But after reading this thread I understood that to have a 
> kernel with both patches (i-pipe and preempt_rt) and, I understand, Xenomai-3 
> with the two versions could be a very interesting system to work on.
> 
> For instance, I'm in the robotics field, and after that mails I thought that 
> it could be a good solution that fit the cases where you have several loops, 
> with several rates with different importance.

Several loops with several rates with different importance must be
mapped to tasks with different priorities. It does not make sense to
have them mapped to threads running in different modes.

> Not really. It's nice if you a have a package.

If this if of such prominent importance for you, I suggest it to code
this yourself. It does not make sense to argue with upstream that this
feature is useful, especially with arguments that seems to indicate that
you do not have a complete understanding of the issue, neither that you
tried it and it effectively solves some real problems.

Cheers,
Daniele


