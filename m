Message-ID: <53B30DF0.80301@grandegger.com>
Date: Tue, 01 Jul 2014 21:37:20 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <A7F7E9DFC6DD4132AD68D2EE9D2A451A@pc2012PC>
In-Reply-To: <A7F7E9DFC6DD4132AD68D2EE9D2A451A@pc2012PC>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CAN bus on beaglebone black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marko Roganovic <marko.roganovic@pupin.rs>, xenomai@xenomai.org

On 07/01/2014 10:30 AM, Marko Roganovic wrote:
> Dear Xenomai users and developers,
> 
> 
> 
> I am relatively new to Xenomai, and we are working on a project that uses Beaglebone black platform (3.8.13xenomai kernel). The idea is to port our code that runs on x86 platform and RTAI Linux interface, to Beaglebone black. In a process we decided to switch from RTAI to Xenomai. Most of the job is done relatively with no problems, but now we are facing the challenge how to connect our proprietary hardware to this new Beaglebone black platform. The idea is to use CAN bus, since it best suits real time constraints that we must meet. 
> 
> 
> 
> As I understood, in rtcan core within Xenomai, there is no support for c_can (d_can) driver which is used on Beaglebone black (we tried kernel driver and it worked with our hardware fine). So I am interested if someone is working on porting this driver to rtcan (or has ported it already). Any help is appreciated.

Yes, the c_can linux kernel driver needs to be ported to rtcan. This
should be rather straight forward. I have done it some time ago for the
Flexcan controller.

Wolfgang.


