Message-ID: <50CC65AF.6040102@xenomai.org>
Date: Sat, 15 Dec 2012 12:57:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rMVEY5_Ris9_HGPpsUFht-CdvPdWhPm7jtJ4qfZoyVjKw@mail.gmail.com>
In-Reply-To: <CAPpP=rMVEY5_Ris9_HGPpsUFht-CdvPdWhPm7jtJ4qfZoyVjKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM - Dynamic linking of device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: xenomai@xenomai.org

On 12/13/2012 10:21 AM, alex alex wrote:

> Hi,
> 
> I need to link new devices once my module is loaded and I'd like to know if
> we can do this with RTDM?
> Are we forced to link the device in the "_init" fonction ?


If you link the device in the "_init" function it will link the new
device once the module is loaded.

> Or is there an
> other way to do the connection device/driver than using
> rtdm_dev_register<http://www.xenomai.org/documentation/trunk/html/api/group__devregister.html#ga6a191b3d206680c48cad2047adb9fc98>wich
> doesn't allow to do what I want?


I do not really understand what you are talking about. If something does
not work, please post code demonstrating what does not work.

-- 
                                                                Gilles.

