Message-ID: <bc4264770702231129j54ad8d5bx6d02fb1e8af62780@domain.hid>
Date: Fri, 23 Feb 2007 19:29:47 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] what makes a driver real-time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

this may be a dumb question but what has a real-time driver got that
the normal driver does not have?

Example:
Say I want to talk to a remoteIO station via ethernet. The vendor
provides a c library with API-calls with which I can interact with the
remote device. His library probably makes use of the normal socket.h
stuff and the normal network adapter driver.

If I call his API's from a xenomai task why would there be a problem
with using the vendors non-real-time API?

The way I understand the documentation of xenomai all interrupts from
hardware are channeled through adeos so that counts for our network
device as well. Same for other user-space  processes that want to get
hold of the network device. As long as a xenomai task has got hold of
the network device adeos will not let other processes interrupt the
connection between task and device.

What am I missing?

Regards,

Roland

