Message-ID: <55C17C8E.5000909@gatech.edu>
Date: Tue, 04 Aug 2015 23:01:34 -0400
From: "Yogi A. Patel" <yapatel@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jorge Ramirez Ortiz <jro@xenomai.org>

Hi -

I am migrating a xenomai 2.5.4 application to the cobalt core. I have 
xenomai 3.0-rc5 installed with 3.18.12.

I have a NI PCI 6250 card that is attached via analogy_config. I can 
successfully run the insn_read command that is installed with the user 
space support by running:

sudo ./insn_read -d analogy0 -c 3 -R 0 --verbose

This prints out a set of values close to what I am expecting (5V)

I then attempt to use the analogy calibration feature added to Xenomai 3 
by running:

sudo ./analogy_calibrate --device=analogy0 --output=calvals.bin

This prints out the following:

    0"000.079| calibration output: calvals.binls
    0"004.427| calibrating device: analogy_ni_pcimio
    0"255.934| Polynomial :
    0"255.972|     order =  3
    0"255.995|     expansion origin =  32767.000000
    0"256.026|     order  0  coefficient =  32867.5
    0"256.051|     order  1  coefficient =  0.949174
    0"256.075|     order  2  coefficient =  -1.45506e-07
    0"256.099|     order  3  coefficient =  -6.56837e-12
    0"283.024| volt_ref                = 6.9204
    0"283.060| measured_gnd_cde    = 32770.9, linearized_gnd_cde = 32871.3
    0"283.082| measured_ref_cde = 54247.1, linearized_ref_cde  = 53123.6
    0"283.099| full_correction(measured_gnd_cde)    = 8.88619e-16
    0"283.113| full_correction(measured_ref_cde) = 6.9204
    0"283.126| Polynomial :
    0"283.139|     order =  3
    0"283.154|     expansion origin =  32767.000000
    0"283.171|     order  0  coefficient =  -0.0012794
    0"283.188|     order  1  coefficient =  0.000324341
    0"283.204|     order  2  coefficient =  -4.97205e-11
    0"283.221|     order  3  coefficient =  -2.24447e-15
    0"283.294| Calibrating AI: �m
    0"283.329| upTicks=32 code=60408.4 pwm_cal=9.01368 
adrange_cal=8.87857 lsb_error=-421.704
    0"283.348| upTicks=64 code=57672.3 pwm_cal=8.01405 
adrange_cal=8.01103 lsb_error=-9.45353
    0"283.364| upTicks=96 code=54576.5 pwm_cal=7.01443 
adrange_cal=7.02551 lsb_error=34.5815
    0"283.380| upTicks=128 code=51476.6 pwm_cal=6.01481 
adrange_cal=6.0349 lsb_error=62.7115
    0"283.396| upTicks=160 code=48378.7 pwm_cal=5.01519 
adrange_cal=5.04158 lsb_error=82.3696
    0"283.412| upTicks=192 code=45280.8 pwm_cal=4.01557 
adrange_cal=4.04528 lsb_error=92.7275
    0"283.428| upTicks=224 code=42183.3 pwm_cal=3.01595 
adrange_cal=3.04652 lsb_error=95.4243
    0"283.444| upTicks=256 code=39086.4 pwm_cal=2.01633 
adrange_cal=2.0458 lsb_error=91.9984
    0"283.463| upTicks=288 code=35987.9 pwm_cal=1.01671 
adrange_cal=1.04281 lsb_error=81.4655
    0"283.479| upTicks=320 code=32889.6 pwm_cal=0.0170864 
adrange_cal=0.0384727 lsb_error=66.7551
    0"283.495| upTicks=352 code=29792.5 pwm_cal=-0.982535 
adrange_cal=-0.966418 lsb_error=50.3061
    0"283.512| upTicks=384 code=26694.2 pwm_cal=-1.98216 
adrange_cal=-1.97227 lsb_error=30.8585
    0"283.528| upTicks=416 code=23595.5 pwm_cal=-2.98178 
adrange_cal=-2.97842 lsb_error=10.4653
    0"283.544| upTicks=448 code=20497.8 pwm_cal=-3.9814 
adrange_cal=-3.98403 lsb_error=-8.22739
    0"283.560| upTicks=480 code=17399.5 pwm_cal=-4.98102 
adrange_cal=-4.98919 lsb_error=-25.515
    0"283.576| upTicks=512 code=14302.1 pwm_cal=-5.98064 
adrange_cal=-5.99302 lsb_error=-38.6486
    0"283.592| upTicks=544 code=11205.1 pwm_cal=-6.98026 
adrange_cal=-6.99529 lsb_error=-46.9177
    0"283.608| upTicks=576 code=8106.3 pwm_cal=-7.97988 
adrange_cal=-7.99633 lsb_error=-51.3279
    0"283.624| upTicks=608 code=5007.67 pwm_cal=-8.9795 
adrange_cal=-8.99506 lsb_error=-48.5709
    0"283.640| upTicks=640 code=1897.36 pwm_cal=-9.97912 
adrange_cal=-9.99492 lsb_error=-49.2985
    0"283.657| calibrating range 1
    0"283.671| adjusted rng_max: 4.5
    0"308.777| volt_ref                = 4.51538
    0"308.799| measured_gnd_cde    = 32770.8, linearized_gnd_cde = 32871.1
    0"308.818| measured_ref_cde = 60800.9, linearized_ref_cde  = 59217.5
    0"308.837| full_correction(measured_gnd_cde)    = 1.45201e-16
    0"308.853| full_correction(measured_ref_cde) = 4.51538
    0"308.867| Polynomial :
    0"308.883|     order =  3
    0"308.902|     expansion origin =  32767.000000
    0"308.923|     order  0  coefficient =  -0.000613011
    0"308.947|     order  1  coefficient =  0.000162674
    0"308.971|     order  2  coefficient =  -2.49375e-11
    0"308.995|     order  3  coefficient =  -1.12572e-15
    0"309.050| done
    0"309.071| calibrating range 2
    0"309.085| adjusted rng_max: 1.8
    0"334.173| volt_ref                = 1.79766
    0"334.198| measured_gnd_cde    = 32770.2, linearized_gnd_cde = 32870.6
    0"334.221| measured_ref_cde = 60734.4, linearized_ref_cde  = 59155.9
    0"334.241| full_correction(measured_gnd_cde)    = 2.63117e-16
    0"334.257| full_correction(measured_ref_cde) = 1.79766
    0"334.271| Polynomial :
    0"334.286|     order =  3
    0"334.310|     expansion origin =  32767.000000
    0"334.334|     order  0  coefficient =  -0.000210829
    0"334.358|     order  1  coefficient =  6.49143e-05
    0"334.381|     order  2  coefficient =  -9.95116e-12
    0"334.405|     order  3  coefficient =  -4.49212e-16
    0"334.429| done

NOTE: there appears to be a print bug above (0"283.294| Calibrating AI: �m)

I then run the following command to utilize those calibration values:

sudo ./insn_read -d analogy0 -c 0 -R 0 -y calvals.bin

This does not print out anything. Watching top shows that lt-insn_read 
consumes 100% of a processor and its memory consumption increases over 
time until causing the system to halt.

After some unorganized debugging, I've found:
+ That the output file (calvals.bin) has size of 0 bytes.
+ When running the insn_read command with "--verbose", nothing is 
printed out.
+ dmesg shows " lt-analogy_cali[21843]: segfault at 7 ip 
00007fc68943aa03 sp 00007fff415993d0 error 4 in 
libc-2.19.so[7fc6893ef000+1bb000]"
+ there appears to never be a call to fclose on FILE p, which most 
likely explains the fact that the file size is 0, HOWEVER - adding 
random printf statements in calibration_ni_m.c eventually leads to a 
calibration file being created with a non-zero size
+ running insn_read with the non-zero calibration file still leads to a 
infinite process time with nothing ever printed out and continued 
consumption of memory and processor until either the system halts or the 
process it killed

Has anyone successfully used the calibration feature?

Yogi

