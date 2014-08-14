Message-ID: <53ED23BB.2070706@nta-inc.net>
Date: Thu, 14 Aug 2014 16:01:47 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <CAEGbdidABiixUba3TiheYcLx1Swh5TrTbt_FtenZsExq7weUYg@mail.gmail.com>	<53E93A3D.2060403@nta-inc.net>
 <CAEGbdicCUdbZddMuYNEvSJreftxqzR_DtcE+KgH_eTkDJQcBLg@mail.gmail.com>
In-Reply-To: <CAEGbdicCUdbZddMuYNEvSJreftxqzR_DtcE+KgH_eTkDJQcBLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] C++ std::thread and xenomai pthread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org >> Xenomai" <xenomai@xenomai.org>

On 08/14/2014 02:27 PM, Matthew Lindner wrote:
> Can you elaborate? Did you check to see if it was using xenomai
> pthreads and was staying in primary mode?

It's been a while since I wrote the code, so it's hard for me to remember the details.  This is why I was reluctant to say more.  I have used the code quite a bit since then, so I am confident it works fine, but I haven't needed to look at the implementation in a while.

Yes, I made sure it was using Xenomai pthreads, stayed in primary mode, and the latency measurements were good.  I don't remember whether creating a std::thread using one of the class constructors works as expected, but I use a factory function, since I usually want to create threads with POSIX scheduling attributes anyway.  In my applications, I usually do something like this:

   std::thread rt_thread(posix_util::create_thread(
                         mq_test, SCHED_FIFO, 16));
   rt_thread.join();

I won't include all of the details here, but it looks like the tricky part goes something like this:

inline
std::thread create_thread(std::function<void()> const& f)
{
     std::thread t;
     auto pthread_t_ptr = (pthread_t*)(void*)(&t);
     *pthread_t_ptr = create_pthread(f);
     return t;
}

The sequence is this:

   1) A dummy std::thread object is created.
   2) The create_pthread function then uses pthread_create to make a standard pthread and return it.
   3) The std::thread object is modified to use the standard pthread object.
   
So, this does not answer the question of whether recompiling libstdc++ is necessary because I use pthread_create instead of the class constructor.  Perhaps the class constructor did not work because of the recompilation issue and that is another reason for this approach -- I'm not sure.

That's about all I can add at this point -- you can do some experiments to see how things work for yourself.  I hope this helps.

-Jeff


