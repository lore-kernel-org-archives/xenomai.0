MIME-Version: 1.0
In-Reply-To: <4a34ed44-275f-ed3a-8548-33a6f1107ef7@xenomai.org>
References: <CALLqZ8TWgsZAzRuYBQ1gd4s5KO_wO_aaY+UyVEMDBw5k9rSQqQ@mail.gmail.com>
 <4a34ed44-275f-ed3a-8548-33a6f1107ef7@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 29 Nov 2017 02:10:06 -0500
Message-ID: <CALLqZ8R=vaUDaWB+XGEdAeHg0O8uxxvtr7SYmYr=9+Mvq_6f5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Gpio-core question
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
  I was testing out my changes and came across some strange behaviour.
I tried two approaches for my changes one where I add two ioctrl commands
to request and release a pin and another where the driver requests and
releases the pin
without the user having to make a call to ioctl.  For the second approach
I added an open call to the gpio driver to handle checking if the pin is
available. During
testing I found that if one pin fails to open all attempts to open any
other pin will also
fail.
   For example I have three pins 953, 954, 957.  I created a test where I
open 953,
then 954 and then 957.  For one test run I export 953 via sysfs, I expect
the output of
my test to fail to open 953 with EBUSY and then successfully open 954 and
957.
I expect to see my open call executed three times.  What I actually see is
all the pins
fail to open.  The driver's open function is only executed once, after that
it looks like
open fails before the call to the drivers open function. The error returned
for all attempts after
the first failure  is EBUSY.  I experimented with the order in which the
test opens pins and found
that after open fails as expected (drivers open function is invoked and
returns EBUSY) every
other call to open also fails but doesn't invoke the drivers open function
but returns EBUSY.
    I traced back through cobalt to see what was happening and found we are
failing in the
call to xnid_enter() in rtdm_fd_enter(). The function xnid_enter fails with
EEXIST when trying
to insert into the tree.  I'm not sure if I'm missing something in my
open() function to handle
cleaning up resources after an unsuccessful attempt to open a pin.
  For my open call I used the open operations that are in the serial and
spi drivers as a guide.
If request_gpio() fails, I return that value from open(), I've included my
code for open():

int gpio_pin_open(struct rtdm_fd *fd, int oflags)
{
struct rtdm_gpio_chan *chan = rtdm_fd_to_private(fd);
struct rtdm_device *dev = rtdm_fd_device(fd);
unsigned int gpio = rtdm_fd_minor(fd);
int ret = 0;
struct rtdm_gpio_pin *pin;

pin = container_of(dev, struct rtdm_gpio_pin, dev);
ret = gpio_request(gpio, pin->name);
if (ret) {
printk(XENO_ERR "failed to request pin %d : %d\n", gpio, ret);
                return ret;
} else {
chan->requested = true;
}

return 0;
}

I can also post my test code if that helps, I'm not sure if this is a bug
or if I'm missing some clean
up code in my open function to handle unsuccessful attempts to open a pin.

Thanks

Greg

On Fri, Nov 24, 2017 at 5:26 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 11/24/2017 06:37 AM, Greg Gallagher wrote:
> > Hi,
> >   I'm finishing up my work on a patch to add a RTDM gpio driver for
> > the zynq-7000 platform.  I ran into a situation where I needed to call
> > gpio_request in gpio-core because the zynq gpio driver uses the
> > gpio_request function to enable the gpio pins on the board.
> >     A side effect that I found when testing is that the driver will fail
> to
> > load
> > if another application has exported a gpio pin via sysfs and likewise
> sysfs
> > won't allow anyone to export gpio pins once the rtdm gpio driver has been
> > loaded.
> > My implementation calls gpio_request on each pin as they are  registered
> > under /dev/rtdm.
> >     I'm not sure if the above is an issue or not, if the RTDM driver has
> > claimed the
> > gpio pins then I think it would make sense for them not to be accessible
> by
> > applications
> > via sysfs.  If my assumption is not correct then maybe one option could
> be
> > to only call gpio_request on each pin as need, maybe via ioctl?
> >
> > Any guidance would be appreciated,
> >
>
> gpio-core deals with entire GPIO controllers, so claiming every pin from
> every bank on the controller for rt usage unconditionally seems overkill.
>
> The ioctl option seems a better option, but then you would have to be
> careful about not conflicting with request_gpio_irq() which does request
> input pins. rtdm_gpio_chan->requested tells whether a pin as already
> been claimed.
>
> --
> Philippe.
>
