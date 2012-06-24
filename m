Message-ID: <4FE6F7C4.7030500@tudelft.nl>
Date: Sun, 24 Jun 2012 13:19:32 +0200
From: Uwe Fechner <u.fechner@tudelft.nl>
MIME-Version: 1.0
References: <CAKKWdtf6_qRDcGs762F=9WGc7BNnHoq4-07x37sY8kPvZRS07A@mail.gmail.com>
In-Reply-To: <CAKKWdtf6_qRDcGs762F=9WGc7BNnHoq4-07x37sY8kPvZRS07A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question:deadline for the real devices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

 Hi,

for realtime I/O you need drivers that support Xenomai. They are available for serial I/O,
CAN bus, Ethercat and probably more.

Avoid USB (not as realiable as needed for industrial applications).

With respect to disc I/O: First of all use an SSD harddisc that has a RAM input cache.

Than you could also create a thread that receives data via a realtime queue and
writes it with a lower priority the hard disc. I am not sure if this is always
needed.

Best regards:

Uwe Fechner

On 24.06.2012 12:59, ali hagigat wrote:
> When we talk about Xenomai and a hard real time system, every thing
> seems OK regarding to tasks and the CPU code, what about the
> functionality of I/O devices?
>
> Like there is no guarantee for writing a sector on a hard disk below a
> specified time. Or reading/writing a USB device.
>
> I mean doing a real input/output action seems not to have a specific
> deadline. While sometimes it seems we need to have it.
>
> Any comment and direction will be appreciated much.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


-- 
----------------------------------------
Uwe Fechner, M.Sc.
Delft University of Technology
Faculty of Aerospace Engineering/ASSET
Kluyverweg 1,
2629 HS Delft, The Netherlands
Phone: +31-15-27-88902


