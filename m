From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <560BF7D1.5020702@xenomai.org>
Date: Wed, 30 Sep 2015 10:55:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] aarch64: boards/sensor_boards for prototyping
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


I thought the exchange below (from dev@lists.96boards.org) might be of interest
to people in this mailing list.
As aarch64 support is merged in Xenomai, teams looking to validate low cost
prototypes in this architecture have a choice of boards (different SoC
manufacturers) and mezzanine products below [0]

This site is maintained by Linaro (non for profit) so devices are reasonably priced.
Also the design files for things like the UART adapter board or the sensors
board are also published.

Notice that I am only sharing this info because affordable aarch64 development
boards are hard to find.

[0] https://www.96boards.org/products/
[1] https://github.com/96boards/96boards-sensors
[2] https://github.com/96boards/96boards-uart


On Wed, Sep 30, 2015 at 3:31 PM, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
> On 09/30/2015 08:20 AM, Grant Likely wrote:
>> >>> Update on the Sensors board.
>> >>>
>> >>> Unfortunately, some of the boards got shipped out without the Arduino
>> >>> bootloader installed on the Atmel. Before you can use the procedure in
>> >>> the starter guide, you'll need to disconnect the Sensors board from
>> >>> your 96boards baseboard and flash the bootloader. Pretty much any
>> >>> flashing method will work, but the easiest is probably to use another
>> >>> Arduino as a programmer as documented here (unless you already have an
>> >>> AVR-ISP programmer, in which case use that):
>> >>>
>
>
> are there any plans to create another accessory sensor board (just like this
> one) that only provides the same standard form factor and connectors to buses
> and sensors but without a micro-controller in it?

Yes. We have a design called the Grove board and we'll be doing a
prototype run of it in the next week or so. I don't know if we will
manufacture and sell it commercially though.

Design files are here:

https://git.linaro.org/people/grant.likely/96boards-grove.git

> Maybe it could be advertised under "miscellaneous" accessories below? Not sure
> who/how gets decided what goes in here.
> https://www.96boards.org/products/accessories/
>
> We demoed an early Xenomai release showing realtime control from userspace Linux
> on aarch64 last week during Connect using the Hikey6220; some of us would be
> very interested on having a bare sensor board like this (just for commodity of
> access) to build some prototypes.

That would be great.

g.


-- 
jro


