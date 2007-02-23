From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17887.20773.224989.488558@domain.hid>
Date: Fri, 23 Feb 2007 21:40:05 +0100
Subject: Re: [Xenomai-help] what makes a driver real-time
In-Reply-To: <bc4264770702231129j54ad8d5bx6d02fb1e8af62780@domain.hid>
References: <bc4264770702231129j54ad8d5bx6d02fb1e8af62780@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
 > Hi,
 > 
 > this may be a dumb question but what has a real-time driver got that
 > the normal driver does not have?

a real-time driver can handle interrupts as soon as the real-time kernel
has exited all its interrupt disabling sections. A normal driver on the
other hand, must wait for Linux to exit all its interrupt disabling
sections. This means that a real-time driver can preempt Linux at any
time, even at a time when Linux data are not in a consistent state, that
is why it is forbidden for a real-time driver to call Linux services.

 > 
 > Example:
 > Say I want to talk to a remoteIO station via ethernet. The vendor
 > provides a c library with API-calls with which I can interact with the
 > remote device. His library probably makes use of the normal socket.h
 > stuff and the normal network adapter driver.
 > 
 > If I call his API's from a xenomai task why would there be a problem
 > with using the vendors non-real-time API?

Calling the Linux kernel system calls such as socket from your Xenomai
task will cause it to switch to secondary mode, which means that it will
have no more determinism than a standard Linux task.

 > 
 > The way I understand the documentation of xenomai all interrupts from
 > hardware are channeled through adeos so that counts for our network
 > device as well. Same for other user-space  processes that want to get
 > hold of the network device. As long as a xenomai task has got hold of
 > the network device adeos will not let other processes interrupt the
 > connection between task and device.
 > 
 > What am I missing?

You misunderstood Adeos and the way Xenomai work, I suggest you read:
http://www.xenomai.org/documentation/branches/v2.0.x/pdf/Life-with-Adeos.pdf
and
http://www.xenomai.org/documentation/branches/v2.0.x/pdf/Native-API-Tour.pdf

-- 


					    Gilles Chanteperdrix.

