Message-ID: <51780A72.3080104@gmail.com>
Date: Wed, 24 Apr 2013 18:38:10 +0200
From: Victor Hiairrassary <victor.hiairrassary.ml@gmail.com>
MIME-Version: 1.0
References: <517536B8.4080508@gmail.com> <51766F9F.6070407@xenomai.org>
	<E3B5BC29-0015-4473-B5F5-304EEAEC8122@gmail.com>
	<5176D2FB.8050101@xenomai.org>
In-Reply-To: <5176D2FB.8050101@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to use rtdm_(io/m)map_to_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/23/2013 08:29 PM, Gilles Chanteperdrix wrote:
>
> The register access is almost certainly the wrong abstraction layer.
> If you need writing to registers 2 to 13 starts a motor, then, there
> should be an ioctl START_THE_MOTOR, which implementation in RTDM driver
> writes to registers 2 to 13. In other words, without knowing what you do
> with this FPGA there is no way to answer.
>
> Anyway, if the 1024 registers are 1024 parameters of the FPGA which you
> need to configure individually, you can create an ioctl with a structure
> where you pass the register number and the value.
>
>
Really thanks for your answers ! We have some actions binded to registers :
for example, read registers 5 return current speed, etc.

So we will use an real-time device driver ! Do we need to call 
devm_request_and_ioremap()
in driver initialization, like in linux device driver? i.e. is it 
allowed and recommended with rtdm?

Regards,
Victor Hiairrassary
