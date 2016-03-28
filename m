References: <56E5F4B4.9030807@googlemail.com>
 <CA+CJOCzH=jrnM70D3=8ix1i25eMGpemv_Te_Tk3aWbUeZ86j6g@mail.gmail.com>
 <BLU437-SMTP29D359A6746B3F160FFE69F0890@phx.gbl>
 <CA+CJOCyuEohMS4NjtOmewB+7BzbG=OTCQ2UfESamyoA736J4Xw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56F8FD2B.6060502@xenomai.org>
Date: Mon, 28 Mar 2016 11:45:15 +0200
MIME-Version: 1.0
In-Reply-To: <CA+CJOCyuEohMS4NjtOmewB+7BzbG=OTCQ2UfESamyoA736J4Xw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3.0.1 with raspberry pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>, Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On 03/21/2016 04:41 PM, Nicolas SCHURANDO wrote:
> Thanks Mathieu for the reminder. I had bookmarked Philippe's new year
> message introducing the specific vendor branch, but in the interval I
> somehow forgot it existed.
> 
> I was able to produce a working Xenomai 3.0 image for the Raspberry Pi 1
> using the bcmrpi_defconfig as a base. It seems stable so far.
> 
> However, when using bcm2709_defconfig, the generated kernel won't boot on a
> Raspberry Pi 2, leaving me with the initial rainbow screen.
> 
> Philippe, have you had any feedback from people testing on the Raspberry Pi
> 2 yet ?
> 

Sorry, this message was buried in a bottomless log. I received no
feedback regarding this specific target. The original work was aimed at
porting to the RPI Zero, which is the only target I have tested so far.
Other changes are untested by-products of that work, which should be
considered as a template for porting to other RPI SBCs based on the
bcm270x families.

-- 
Philippe.

