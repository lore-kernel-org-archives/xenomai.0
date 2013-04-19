Message-ID: <5171A299.60905@grandegger.com>
Date: Fri, 19 Apr 2013 22:01:29 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
	<516BA7C4.1050403@grandegger.com>
	<CADVgf9nD4Qkaz54ba1PuKx0h1WkSkhPYQM9C0RU2LkE7aE96nQ@mail.gmail.com>
	<516E336C.1060509@xenomai.org>
	<CADVgf9=CJ0MQEpsub3g=bDZvxk3U3G1tDDvjvFm1jZRmke35fg@mail.gmail.com>
	<CAD1EtoiQm8rZtkDTjZK8Tq3xeDKHULjc7V6Stg=bZ9XpEp5o7w@mail.gmail.com>
	<516F9E87.6020002@grandegger.com> <516FA077.20400@grandegger.com>
	<CAD1EtoiZ05S5HXEvdq2+Sg6-1XbxHwMUpcVMrpYA6gv0JgLqJw@mail.gmail.com>
	<5171069C.3020909@grandegger.com>
	<CAMsuG6pte10W8AbABnwAzLnVKF6kTRv+M5m2o=JE6z6oT_Qc4g@mail.gmail.com>
In-Reply-To: <CAMsuG6pte10W8AbABnwAzLnVKF6kTRv+M5m2o=JE6z6oT_Qc4g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch to src/utils/can/rtcansend.c to support data
 from a file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Carles Lopez <carles.lopez@pal-robotics.com>
Cc: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>, xenomai@xenomai.org

On 04/19/2013 03:58 PM, Carles Lopez wrote:
> Hi,
> 
> as Daniel we are here also interested in dumping CAN frames to our
> devices and extending/adding this tool to Xenomai would be great.
> 
> Sometimes in our company it's really useful to save the rtcanrecv
> output and, sometime later, send it in order to reproduce CAN traffic.
> 
> do you guys think that it's interesting that rtcansendmulti supports
> same syntax than rtcanrecv output?
> To do for instance:
> rtcanrecv | rtcansendmulti -

Good idea. Sounds useful.

Wolfgang.



