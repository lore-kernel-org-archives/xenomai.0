Message-ID: <449066DC.8070204@domain.hid>
Date: Wed, 14 Jun 2006 13:43:24 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <44906584.60503@domain.hid>
In-Reply-To: <44906584.60503@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: GPIO and RTDM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

hi Jan, everyone,

>
> Separately..
>
> In this GPIO work, I concluded that I needed to add a sysfs interface
> to my driver, in order to better fit with LKML expectations.

Sysfs GPIO representation of Hardware (v0.2)
(v0.1 went to lm-sensors ML, v0.2 to kernelnewbies ML)

We need a standard rep for GPIO in sysfs, so heres a strawman.
Strike a match, lets have a campfire!

Essentially, this seeks to describes the directory of
'device-attribute-files' that are populated by a driver,

forex:

soekris:/sys/bus/platform/devices/pc8736x_gpio.0# ls
bit_0.0_debounced       bit_1.2_totem           bit_2.5_pullup_enabled
bit_0.0_locked          bit_1.3_debounced       bit_2.5_totem
bit_0.0_output_enabled  bit_1.3_locked          bit_2.6_debounced
bit_0.0_pullup_enabled  bit_1.3_output_enabled  bit_2.6_locked
bit_0.0_totem           bit_1.3_pullup_enabled  bit_2.6_output_enabled
bit_0.1_debounced       bit_1.3_totem           bit_2.6_pullup_enabled
bit_0.1_locked          bit_1.4_debounced       bit_2.6_totem
bit_0.1_output_enabled  bit_1.4_locked          bit_2.7_debounced
bit_0.1_pullup_enabled  bit_1.4_output_enabled  bit_2.7_locked
bit_0.1_totem           bit_1.4_pullup_enabled  bit_2.7_output_enabled
bit_0.2_debounced       bit_1.4_totem           bit_2.7_pullup_enabled
bit_0.2_locked          bit_1.5_debounced       bit_2.7_totem

(Ive now seen *1.5* GPIO architectures, so please test this writeup
mentally against your GPIO experience).


Basic Naming Convention.

I havent seen this stated anywhere at an 'all-of-sysfs-level' and I
think its true/valid (and so test this here - CMIIW).  If Im correct,
please suggest the optimal Doc/* file to contain this info.

All device-attr-files are named as <prefix>_<id>_<suffix>

in LM-sensors:
- prefix        sensor-type: in(volts), temp, fan, etc..
- id            usually single integer
- suffix        the sensor attribute in question.


GPIO Prefix Names.

Basically, GPIO hardware design appears to have 2 top-level factors;
pin features, and pin-to-port grouping.  These get mapped into
filename prefixes & suffixes.

All GPIOs (Ive seen) are organized as 1-4 ports of 8-32 bits.  The
bits' attributes are addressable individually, but also accessible as
a group via the port_* files.  If you change a bit-attribute, that
change will also exhibit in the port attr too.

IOW, we have bit_*, port_*.  They are interconnected at the hardware
level, and (I think) there is no need for inter-locks between the
sysfs handlers for bit_ and port_ (except for shadow regs, but I
digress)


GPIO Architectures

GPIO pins have lots of hardware / architectural / naming-convention
variations, which makes this harder.

Drivers should create sysfs 'files' only for attributes that are
pertinent for the hardware being driven.  Ths way, the absense or
presense of files communicates functionality, as does their
readonlyness.  (these 'behaviors' may be different than lm-sensors)

IOW:
if a pin is input  only, it shouldnt have an _output_enabled attr.
if a pin is output only, it shouldnt have an _output_enabled attr.

The reason for the 2nd rule: the presense of _output_enabled suggests
that it can be changed.

OTOH, a readonly _output_enabled would yield the same, but not as
visibly (ls vs ls -l)

So, Im somewhat ambivalent here, looking for input....


User-Space

Following LM-sensors approach, a user-side library would add the
niceties:

- provide any equivalences needed by users
  ie bit_x_tristate = ! bit_x_output_enabled.

- sub-port allocation and management.
  support for 3+3+2 bit sub-ports on an 8 bit port would be nice

I suspect that a sophisticated programmer would be able to add a
sub-port allocation facility w/in the driver.  I cannot,



GPIO Pin Features

As alluded, pin features are represented as _<suffixes>

1st: there are several alternative naming schemes:

- name-as-verb          _output_enable          (conveys an 'action')
- name-as-state         _output_enabled         (conveys a 'current state')
- feature-name          _output                 (a knob to turn)
- feature+state         _output+(currval)       (currval in name is bad 
idea)

1,2 are quite close.  Ive done 2.

FWIW, heres the pin attributes of my GPIOs, as expressed in the syslog
by the legacy drivers: (these are

[15510.384000]  pc8736x_gpio.0: io16: 0x0004 TS OD PUE  EDGE LO         
io:0/1
[15510.564000]  pc8736x_gpio.0: io17: 0x0004 TS OD PUE  EDGE LO         
io:1/1
[15510.744000]  pc8736x_gpio.0: io18: 0x0004 TS OD PUE  EDGE LO         
io:1/1
[15510.928000]  pc8736x_gpio.0: io19: 0x0004 TS OD PUE  EDGE LO         
io:1/1


# whether output-drive is on/off
_output_enable          # 1 or 0,
_tristate               # ! _output_enable, logically linked.

Now, theres no need to have both of these; if there were, they would
have to be intrinsically linked (logically opposite values).

IOW, drivers should name the file as one of possible states of the
feature, which ever best describes it, and not expose it 2x.

To the extent that we need support for '_tristate' version of a
'_output_enabled' sysfs-file, user-space (libraries) should provide
that support.

# output circuit configuration
_opendrain              # only 1 transistor, can sink current from pin
_totem                  # has 2nd transistor, can drive pin hi.
_pushpull               # alias for _totempole

Ive chosen _totem as the attribute name

_pullup_enabled         # pin tied to power via resistor.
_pullup_off             # duh
_pullup_no              # how many aliases ?

_debounce               # present if supported, 0 if off, 1 if on.

It kinda works, but the pullup is a bit ugly, and all the aliases
suggest some semantic difficulty/mismatch/incompleteness, but adding
them all definitely creates clutter and has reached diminished
incremental value.


If hardware doesnt support a feature, like _opendrain, it:

 - sets _pushpull to 1, readonly ?
 - sets _opendrain to 0, readonly ?
    OR never creates _opendrain ?

Doing either of these works to communicate the feature-set to
user-space, but not creating _opendrain when pin doesnt do it means
that the file's presense communicates this; IOW, user issues 'ls', not
'ls -l' to find out.

(continuing strawman)

_value          # read the pin
(no-suffix)     # alias for _value

_current        # the value 'driven' by the pin (last written)

And here we can see some potential (user) difficulties;
under some conditions,
- read-value = current-value

but not on these:
- pin is input-only/tristate - (current is irrelevant, except as 'state')
- pin is over-driven by attached circuit
-- pin cannot sink/supply sufficient current

Detecting these situations is both hardware and circuit dependent, and
properly belongs in user-space.  It sounds a lot like what lm-sensors
does already.

For the 2 drivers Ive 'experienced', pin control was via device-file,
with this command-set.  Presumably the correspondence with the sysfs
strawman above is obvious.

case 'O':        output enabled
case 'o':        output disabled
case 'T':        output is push pull
case 't':        output is open drain
case 'P':        pull up enabled
case 'p':        pull up disabled




Port Organization.

My *vast* experience (with 1.5 GPIO architectures) suggests that all
chips organize their GPIOs into one or more ports.  Each port supports
reading and writing all bits simultaneously.

Some hardware also supports reading/writing pin-properties like
output-enable in a single-word (todo-research).  Drivers for these
hardwares could/should create attributes for each pin-property that is
accessible as a bit-vector.

Further, port (and pin) capabilities generally vary by port; hardware
will typically put a full set of features on 1 port, and less on
others, expecting a designer to allocate functions to pins
accordingly.  Forex, on the pc8736x chip, port 0 can issue interrupts,
so those pins should have extra properties.

These capabilities must be cleanly representable in any worthwhile
sysfs/GPIO model (and we continue to test this strawman)..


Port-names and Pin-names

# prefixes (note the trailing _)
port_[0..P]_
bit_[P]_[0..bits-per-word]_

Getting past the port/bit names, these files are populated by the
driver according to the device.  For the 2 drivers Ive touched, heres
the table:

driver:         ports   bits-per-port
scx200_gpio     1       32
pc8736x_gpio    4       8




Strawman tie-together:

bit_0_0_output_enable   # shows current output-drive of port 0 bit 0
bit_0_0_value
bit_0_0                 # 2 reads of same bit

# lessee what happens :->
port_0_value_bin        # 1-4 bytes typically returned (depending on device)
port_0_value_hex        # converted to human readable, always printable
port_0_value            #

port_1_output_enable    # read/write vector of enable bits to port
port_1_<suffix_set>     #


The driver should know which properties are readable/writable in a
bit-vector basis, and expose those sysfs-attributes only.  Thus the
presense of the port_N_value* attrs implies that all the bits in that
port are readable at once.

If the driver doesnt expose forex: port_1_output_enable, user-space is
free to loop over each bit, in essence 'emulating' the port-wide
operation.


RESTATING - whats above kinda hangs together.

NEXT - muddles

pin_XY_output_state     # one-of( 'output_enable', 'tristate')

This might be convenient for some situations, but probably is needless
complication / obfuscation.


pin_XY_state_bin                # binary state reader

This is intended an 'escape-valve' for things that are turn out to be
cumbersome with the above.  This is probably tantamount to an IOCTL,
so might be a hugely bad idea.


pin_XY_interrupt_enable        #
pin_XY_interrupt_trigger_edge
pin_XY_interrupt_trigger_level
pin_XY_interrupt_trigger_edge_rising
pin_XY_interrupt_trigger_edge_falling
pin_XY_interrupt_trigger_level_hi
pin_XY_interrupt_trigger_level_lo

Well - thats a big one - Do we expose any of this ?
- the ability to enable / disable / control hardware interrupt
- or is that insane meddling in such affairs ?

We cant afterall allow mapping of the actual interrupt handler, that
does sound insane (unless hugely carefull)

With the new genirq architecture, things are apparently more
orthogonal, which suggests there might be something to control by
means of attributes such as above.

Further, any of the above attributes could readily be RO; they would
convey info thats at least useful, even if 'control' is too exposing.

Forex, somewhere during boot, the APIC is setup to handle interrupts;
at this point its probably known what the configured state of all
interrrupts is, and this info could be exposed here.  Whether that has
sufficient value is unclear, and certainly not for v.submit-1


when a pin is level-triggered (presumably this can be
determined early in the boot process, as soon as APIC etc would be


setup), the _edge_* attributes vanish, and the _level_{hi,lo} attrs
are set 1/0, and RO.


OK - IM DONE.

Please be liberal with feedback -
- this is wrong
- poorly explained -
- correct ... - boil this down - reduce to a guiding statement
- strip out conjectures



