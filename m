MIME-Version: 1.0
From: Ashok kumar <ashokkumar.bb@gmail.com>
Date: Fri, 3 Aug 2018 17:18:41 +0530
Message-ID: <CAFUnMk=eoGp2rhHFua-nLprjusizQvujzLiP4b8V2r6PEQfv5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] How to allocate Cpu core and memory segment for xenomai
 kernel in boot configuration
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am using xenomai-3 with Rtnet for controlling servo drive  using ethercat
protocol, to control 4 servo drive when I increase the slaves such as servo
drive I get ethercat frames missing in Rtnet.

I have used isolcpus  to isolate a core and taskset -c 0 to run my
application on the particular core but still I am not able to achieve
timings 1ms  to send ethercat frames.

I used numactl and allocated a memory node for my application and still I
am not able to achieve 1ms  to send ethercat frames at accurate time.

*can you help me steps or procedure to provide a dedicated cpu core and
memory segment for xenomai kernel to use so that other application will not
take cpu core timings and memory , while booting xenomai kernel or running
xenomai application.*

Thank you
R.Ashokkumar



<https://mailtrack.io/> Sent with Mailtrack
<https://chrome.google.com/webstore/detail/mailtrack-for-gmail-inbox/ndnaehgpjlnokgebbaldlmgkapkpjkkb?utm_source=gmail&utm_medium=signature&utm_campaign=signaturevirality>
