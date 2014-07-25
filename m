From: "Steve M. Robbins" <steve@sumost.ca>
Date: Fri, 25 Jul 2014 10:59:34 -0500
Message-ID: <2315226.vOef3bTQnz@riemann>
In-Reply-To: <53D274F6.30005@gmail.com>
References: <1705234.5kun8kYdZP@riemann> <1927199.3ixLvlnsCr@riemann>
 <53D274F6.30005@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] POSIX application running under xenomai -- what do
	wrapped functions do?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Smarzly <smarzlys@gmail.com>
Cc: xenomai@xenomai.org

On July 25, 2014 05:17:10 PM Stefan Smarzly wrote:
> Am 25.07.2014 16:54, schrieb Steve M. Robbins:



> > Secondly, for a user-space task: will it mode switch if there is data
> > available?  If we use TM_NONBLOCK in a user space task, can we avoid the
> > mode switch?
> The task will enter primary mode as soon as you are calling this
> function independent of the flag set to TM_NONBLOCK or not. Otherwise it
> could not test whether data is available at all. And by the way: You
> want to have a task to stay in primary mode as best as you can.
> Otherwise, you do not have any real-time guarantee anymore. So, if the
> task is already in primary mode, there won't be any mode switch.

Of course you are correct; and staying in primary mode is what we desire.  I 
had the modes backwards in my head.  Clearly I needed more caffeine before 
posting :-)

Thanks, Stefan and Philippe for the clarifications!

Best regards,
-Steve


