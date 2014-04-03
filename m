Date: Wed, 2 Apr 2014 20:13:45 -0400 (EDT)
From: "Patel, Yogi A" <yapatel@gatech.edu>
Message-ID: <1644155646.30646957.1396484025089.JavaMail.root@mail.gatech.edu>
In-Reply-To: <2083025521.30645422.1396483998076.JavaMail.root@mail.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] comedi_soft_calibrate file write error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi -

I am using comedi_soft_calibrate to calibrate my M-series DAQ. I have tried asking this question on the comedi group but have not heard anything - so am asking here.

I am running Ubuntu 12.04 with Xenomai 2.6.3, compiled with both analogy and comedi.

I have removed all the analogy kernel modules (using rmmod) and verified that the device is connected to comedi:

rtxi@rtxi:~/Downloads$ cat /proc/comedi
comedi version 0.7.76
format string: "%2d: %-20s %-20s %4d", i, driver_name, board_name, n_subdevices
 0: ni_pcimio            pci-6251               14
ni_pcimio:
 ni_pcimio
8255:
 8255

I run comedi_test and the output is:

rtxi@rtxi:~/Downloads$ sudo comedi_test
I: Comedi version: 0.7.76
I: Comedilib version: unknown =)
I: driver name: ni_pcimio
I: device name: pci-6251
I:
I: subdevice 0
I: testing info...

Now, I am trying to use comedi_soft_calibrate on the card to calibrate it and get the following:

i = 1
    estimate of mean = 60696.3
    estimate of standard deviation = 23.1617
    estimate of standard deviation of mean = 0.189222
i = 2
    estimate of mean = 57605.2
    estimate of standard deviation = 28.5851
    estimate of standard deviation of mean = 0.233529
i = 3
    estimate of mean = 54510.1
    estimate of standard deviation = 41.5673
    estimate of standard deviation of mean = 0.339588
i = 4
    estimate of mean = 51414.8
    estimate of standard deviation = 53.2617
    estimate of standard deviation of mean = 0.435127
i = 5
    estimate of mean = 48319.6
    estimate of standard deviation = 63.4832
    estimate of standard deviation of mean = 0.518632
i = 6
    estimate of mean = 45224.4
    estimate of standard deviation = 72.1341
    estimate of standard deviation of mean = 0.589306
i = 7
    estimate of mean = 42129
    estimate of standard deviation = 78.9516
    estimate of standard deviation of mean = 0.645002
i = 8
    estimate of mean = 39033.8
    estimate of standard deviation = 84.004
    estimate of standard deviation of mean = 0.686279
i = 9
    estimate of mean = 35938.4
    estimate of standard deviation = 86.963
    estimate of standard deviation of mean = 0.710453
i = 10
    estimate of mean = 32843.1
    estimate of standard deviation = 87.954
    estimate of standard deviation of mean = 0.718549
i = 11
    estimate of mean = 29748
    estimate of standard deviation = 87.0501
    estimate of standard deviation of mean = 0.711165
i = 12
    estimate of mean = 26652.5
    estimate of standard deviation = 84.1817
    estimate of standard deviation of mean = 0.68773
i = 13
    estimate of mean = 23557.3
    estimate of standard deviation = 79.2719
    estimate of standard deviation of mean = 0.64762
i = 14
    estimate of mean = 20461.8
    estimate of standard deviation = 72.5195
    estimate of standard deviation of mean = 0.592455
i = 15
    estimate of mean = 17366.5
    estimate of standard deviation = 63.9648
    estimate of standard deviation of mean = 0.522566
i = 16
    estimate of mean = 14271.4
    estimate of standard deviation = 53.8694
    estimate of standard deviation of mean = 0.440091
i = 17
    estimate of mean = 11175.9
    estimate of standard deviation = 42.158
    estimate of standard deviation of mean = 0.344414
i = 18
    estimate of mean = 8080.71
    estimate of standard deviation = 29.2805
    estimate of standard deviation of mean = 0.23921
i = 19
    estimate of mean = 4985.44
    estimate of standard deviation = 15.325
    estimate of standard deviation of mean = 0.125199
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = 32794.6
    order 1 coefficient = 0.946138
    order 2 coefficient = -1.71704e-09
    order 3 coefficient = -1.06054e-13
calibrating base range 0 ...
referenceVoltage=7.01615
measuredGroundCode=32785.8 linearizedGroundCode=32812.4
measuredReferenceCode=54557.7 linearizedReferenceCode=53409.7
fullCorrection(measuredGroundCode)=-1.74061e-16
fullCorrection(measuredReferenceCode)=7.01615
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = -0.00605972
    order 1 coefficient = 0.000322287
    order 2 coefficient = -5.84884e-13
    order 3 coefficient = -3.61258e-17
done.
sanity check:
upTicks=32 code=60696.3 PWMCal=8.99564 ADRangeCal=8.99394 LSBError=-5.28855
upTicks=64 code=57605.2 PWMCal=7.99815 ADRangeCal=7.99805 LSBError=-0.300113
upTicks=96 code=54510.1 PWMCal=7.00066 ADRangeCal=7.0008 LSBError=0.433298
upTicks=128 code=51414.8 PWMCal=6.00317 ADRangeCal=6.00345 LSBError=0.88528
upTicks=160 code=48319.6 PWMCal=5.00567 ADRangeCal=5.00606 LSBError=1.19144
upTicks=192 code=45224.4 PWMCal=4.00818 ADRangeCal=4.00862 LSBError=1.36939
upTicks=224 code=42129 PWMCal=3.01069 ADRangeCal=3.0111 LSBError=1.27841
upTicks=256 code=39033.8 PWMCal=2.0132 ADRangeCal=2.01362 LSBError=1.31279
upTicks=288 code=35938.4 PWMCal=1.01571 ADRangeCal=1.01603 LSBError=0.999436
upTicks=320 code=32843.1 PWMCal=0.0182145 ADRangeCal=0.0184787 LSBError=0.819847
upTicks=352 code=29748 PWMCal=-0.979277 ADRangeCal=-0.979064 LSBError=0.662131
upTicks=384 code=26652.5 PWMCal=-1.97677 ADRangeCal=-1.97669 LSBError=0.236075
upTicks=416 code=23557.3 PWMCal=-2.97426 ADRangeCal=-2.97426 LSBError=-0.00330424
upTicks=448 code=20461.8 PWMCal=-3.97175 ADRangeCal=-3.97189 LSBError=-0.414444
upTicks=480 code=17366.5 PWMCal=-4.96924 ADRangeCal=-4.96943 LSBError=-0.581182
upTicks=512 code=14271.4 PWMCal=-5.96674 ADRangeCal=-5.96693 LSBError=-0.58792
upTicks=544 code=11175.9 PWMCal=-6.96423 ADRangeCal=-6.96449 LSBError=-0.811431
upTicks=576 code=8080.71 PWMCal=-7.96172 ADRangeCal=-7.96195 LSBError=-0.699197
upTicks=608 code=4985.44 PWMCal=-8.95921 ADRangeCal=-8.95937 LSBError=-0.501959
calibrating range 1 ...
referenceVoltage=4.50693
measuredGroundCode=32785.8 linearizedGroundCode=32812.4
measuredReferenceCode=60765.6 linearizedReferenceCode=59281.4
fullCorrection(measuredGroundCode)=1.65835e-16
fullCorrection(measuredReferenceCode)=4.50693
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = -0.00303621
    order 1 coefficient = 0.000161101
    order 2 coefficient = -2.92364e-13
    order 3 coefficient = -1.80581e-17
done.
calibrating range 2 ...
referenceVoltage=1.795
measuredGroundCode=32786 linearizedGroundCode=32812.6
measuredReferenceCode=60642.9 linearizedReferenceCode=59165.4
fullCorrection(measuredGroundCode)=3.21615e-17
fullCorrection(measuredReferenceCode)=1.795
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = -0.00122608
    order 1 coefficient = 6.44452e-05
    order 2 coefficient = -1.16955e-13
    order 3 coefficient = -7.2238e-18
done.
i = 1
    estimate of mean = 60456.3
    estimate of standard deviation = 71.904
    estimate of standard deviation of mean = 0.587427
i = 2
    estimate of mean = 57391.6
    estimate of standard deviation = 131.145
    estimate of standard deviation of mean = 1.0714
i = 3
    estimate of mean = 54323.2
    estimate of standard deviation = 181.793
    estimate of standard deviation of mean = 1.48518
i = 4
    estimate of mean = 51254.6
    estimate of standard deviation = 223.992
    estimate of standard deviation of mean = 1.82992
i = 5
    estimate of mean = 48186.1
    estimate of standard deviation = 259.28
    estimate of standard deviation of mean = 2.11821
i = 6
    estimate of mean = 45117.4
    estimate of standard deviation = 288.284
    estimate of standard deviation of mean = 2.35517
i = 7
    estimate of mean = 42048.9
    estimate of standard deviation = 310.656
    estimate of standard deviation of mean = 2.53794
i = 8
    estimate of mean = 38980.4
    estimate of standard deviation = 326.743
    estimate of standard deviation of mean = 2.66936
i = 9
    estimate of mean = 35911.6
    estimate of standard deviation = 336.417
    estimate of standard deviation of mean = 2.74839
i = 10
    estimate of mean = 32843.1
    estimate of standard deviation = 339.733
    estimate of standard deviation of mean = 2.77548
i = 11
    estimate of mean = 29774.6
    estimate of standard deviation = 336.786
    estimate of standard deviation of mean = 2.75141
i = 12
    estimate of mean = 26705.8
    estimate of standard deviation = 327.529
    estimate of standard deviation of mean = 2.67578
i = 13
    estimate of mean = 23637.3
    estimate of standard deviation = 311.822
    estimate of standard deviation of mean = 2.54746
i = 14
    estimate of mean = 20568.6
    estimate of standard deviation = 289.866
    estimate of standard deviation of mean = 2.36809
i = 15
    estimate of mean = 17499.9
    estimate of standard deviation = 261.264
    estimate of standard deviation of mean = 2.13442
i = 16
    estimate of mean = 14431.5
    estimate of standard deviation = 226.372
    estimate of standard deviation of mean = 1.84937
i = 17
    estimate of mean = 11362.7
    estimate of standard deviation = 184.914
    estimate of standard deviation of mean = 1.51068
i = 18
    estimate of mean = 8294.08
    estimate of standard deviation = 135.367
    estimate of standard deviation of mean = 1.10589
i = 19
    estimate of mean = 5225.63
    estimate of standard deviation = 74.33
    estimate of standard deviation of mean = 0.607246
sanity check:
upTicks=32 code=60456.3 PWMCal=1.7833 ADRangeCal=1.78297 LSBError=-5.01333
upTicks=64 code=57391.6 PWMCal=1.58556 ADRangeCal=1.58553 LSBError=-0.368521
upTicks=96 code=54323.2 PWMCal=1.38781 ADRangeCal=1.38784 LSBError=0.442178
upTicks=128 code=51254.6 PWMCal=1.19007 ADRangeCal=1.19012 LSBError=0.790622
upTicks=160 code=48186.1 PWMCal=0.992332 ADRangeCal=0.992406 LSBError=1.14556
upTicks=192 code=45117.4 PWMCal=0.794591 ADRangeCal=0.79467 LSBError=1.22841
upTicks=224 code=42048.9 PWMCal=0.596849 ADRangeCal=0.59693 LSBError=1.25324
upTicks=256 code=38980.4 PWMCal=0.399108 ADRangeCal=0.399193 LSBError=1.31119
upTicks=288 code=35911.6 PWMCal=0.201367 ADRangeCal=0.201428 LSBError=0.955677
upTicks=320 code=32843.1 PWMCal=0.00362567 ADRangeCal=0.0036785 LSBError=0.820027
upTicks=352 code=29774.6 PWMCal=-0.194116 ADRangeCal=-0.194071 LSBError=0.685161
upTicks=384 code=26705.8 PWMCal=-0.391857 ADRangeCal=-0.391842 LSBError=0.236786
upTicks=416 code=23637.3 PWMCal=-0.589598 ADRangeCal=-0.589598 LSBError=0.00404527
upTicks=448 code=20568.6 PWMCal=-0.787339 ADRangeCal=-0.787359 LSBError=-0.311395
upTicks=480 code=17499.9 PWMCal=-0.985081 ADRangeCal=-0.985118 LSBError=-0.578341
upTicks=512 code=14431.5 PWMCal=-1.18282 ADRangeCal=-1.18286 LSBError=-0.581626
upTicks=544 code=11362.7 PWMCal=-1.38056 ADRangeCal=-1.38062 LSBError=-0.807888
upTicks=576 code=8294.08 PWMCal=-1.5783 ADRangeCal=-1.57835 LSBError=-0.767596
upTicks=608 code=5225.63 PWMCal=-1.77605 ADRangeCal=-1.77607 LSBError=-0.444201
calibrating range 3 ...
referenceVoltage=0.899641
measuredGroundCode=32786.5 linearizedGroundCode=32813
measuredReferenceCode=60712.6 linearizedReferenceCode=59231.3
fullCorrection(measuredGroundCode)=1.11358e-16
fullCorrection(measuredReferenceCode)=0.899641
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = -0.000627312
    order 1 coefficient = 3.22195e-05
    order 2 coefficient = -5.84717e-14
    order 3 coefficient = -3.61155e-18
done.
calibrating range 4 ...
referenceVoltage=0.448543
measuredGroundCode=32787.1 linearizedGroundCode=32813.6
measuredReferenceCode=60627.9 linearizedReferenceCode=59151.2
fullCorrection(measuredGroundCode)=4.12127e-17
fullCorrection(measuredReferenceCode)=0.448543
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = -0.000323702
    order 1 coefficient = 1.61132e-05
    order 2 coefficient = -2.92421e-14
    order 3 coefficient = -1.80616e-18
done.
i = 1
    estimate of mean = 60448.8
    estimate of standard deviation = 70.9464
    estimate of standard deviation of mean = 0.579604
i = 2
    estimate of mean = 57384.8
    estimate of standard deviation = 130.364
    estimate of standard deviation of mean = 1.06503
i = 3
    estimate of mean = 54317.5
    estimate of standard deviation = 181.003
    estimate of standard deviation of mean = 1.47872
i = 4
    estimate of mean = 51249.8
    estimate of standard deviation = 223.222
    estimate of standard deviation of mean = 1.82363
i = 5
    estimate of mean = 48182.4
    estimate of standard deviation = 258.576
    estimate of standard deviation of mean = 2.11246
i = 6
    estimate of mean = 45114.8
    estimate of standard deviation = 287.549
    estimate of standard deviation of mean = 2.34916
i = 7
    estimate of mean = 42047.4
    estimate of standard deviation = 309.936
    estimate of standard deviation of mean = 2.53205
i = 8
    estimate of mean = 38979.9
    estimate of standard deviation = 326.104
    estimate of standard deviation of mean = 2.66414
i = 9
    estimate of mean = 35912.2
    estimate of standard deviation = 335.747
    estimate of standard deviation of mean = 2.74292
i = 10
    estimate of mean = 32844.6
    estimate of standard deviation = 339.098
    estimate of standard deviation of mean = 2.77029
i = 11
    estimate of mean = 29777.2
    estimate of standard deviation = 336.156
    estimate of standard deviation of mean = 2.74626
i = 12
    estimate of mean = 26709.5
    estimate of standard deviation = 326.877
    estimate of standard deviation of mean = 2.67046
i = 13
    estimate of mean = 23642
    estimate of standard deviation = 311.233
    estimate of standard deviation of mean = 2.54265
i = 14
    estimate of mean = 20574.3
    estimate of standard deviation = 289.298
    estimate of standard deviation of mean = 2.36344
i = 15
    estimate of mean = 17506.7
    estimate of standard deviation = 260.657
    estimate of standard deviation of mean = 2.12947
i = 16
    estimate of mean = 14439.3
    estimate of standard deviation = 225.744
    estimate of standard deviation of mean = 1.84424
i = 17
    estimate of mean = 11371.5
    estimate of standard deviation = 184.222
    estimate of standard deviation of mean = 1.50502
i = 18
    estimate of mean = 8303.96
    estimate of standard deviation = 134.577
    estimate of standard deviation of mean = 1.09944
i = 19
    estimate of mean = 5236.56
    estimate of standard deviation = 73.6988
    estimate of standard deviation of mean = 0.602089
sanity check:
upTicks=32 code=60448.8 PWMCal=0.445734 ADRangeCal=0.445658 LSBError=-4.75597
upTicks=64 code=57384.8 PWMCal=0.39631 ADRangeCal=0.396304 LSBError=-0.401319
upTicks=96 code=54317.5 PWMCal=0.346886 ADRangeCal=0.346892 LSBError=0.411885
upTicks=128 code=51249.8 PWMCal=0.297461 ADRangeCal=0.297472 LSBError=0.674681
upTicks=160 code=48182.4 PWMCal=0.248037 ADRangeCal=0.248054 LSBError=1.0828
upTicks=192 code=45114.8 PWMCal=0.198612 ADRangeCal=0.198631 LSBError=1.13117
upTicks=224 code=42047.4 PWMCal=0.149188 ADRangeCal=0.149209 LSBError=1.30431
upTicks=256 code=38979.9 PWMCal=0.0997636 ADRangeCal=0.0997846 LSBError=1.30632
upTicks=288 code=35912.2 PWMCal=0.0503392 ADRangeCal=0.0503548 LSBError=0.971484
upTicks=320 code=32844.6 PWMCal=0.000914749 ADRangeCal=0.000927403 LSBError=0.785514
upTicks=352 code=29777.2 PWMCal=-0.0485097 ADRangeCal=-0.0484994 LSBError=0.634855
upTicks=384 code=26709.5 PWMCal=-0.0979341 ADRangeCal=-0.0979306 LSBError=0.212605
upTicks=416 code=23642 PWMCal=-0.147358 ADRangeCal=-0.147358 LSBError=0.0118389
upTicks=448 code=20574.3 PWMCal=-0.196783 ADRangeCal=-0.196788 LSBError=-0.295773
upTicks=480 code=17506.7 PWMCal=-0.246207 ADRangeCal=-0.246216 LSBError=-0.515435
upTicks=512 code=14439.3 PWMCal=-0.295632 ADRangeCal=-0.29564 LSBError=-0.537546
upTicks=544 code=11371.5 PWMCal=-0.345056 ADRangeCal=-0.34507 LSBError=-0.83921
upTicks=576 code=8303.96 PWMCal=-0.394481 ADRangeCal=-0.394493 LSBError=-0.757159
upTicks=608 code=5236.56 PWMCal=-0.443905 ADRangeCal=-0.443912 LSBError=-0.425058
calibrating range 5 ...
referenceVoltage=0.180078
measuredGroundCode=32789.3 linearizedGroundCode=32815.7
measuredReferenceCode=60746.4 linearizedReferenceCode=59263.2
fullCorrection(measuredGroundCode)=-3.62605e-18
fullCorrection(measuredReferenceCode)=0.180078
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = -0.000143921
    order 1 coefficient = 6.44215e-06
    order 2 coefficient = -1.16912e-14
    order 3 coefficient = -7.22113e-19
done.
calibrating range 6 ...
referenceVoltage=0.0904965
measuredGroundCode=32793.1 linearizedGroundCode=32819.2
measuredReferenceCode=60923.6 linearizedReferenceCode=59430.9
fullCorrection(measuredGroundCode)=-9.05783e-18
fullCorrection(measuredReferenceCode)=0.0904965
Polynomial:
    order = 3
    expansion origin = 32767
    order 0 coefficient = -8.38713e-05
    order 1 coefficient = 3.21747e-06
    order 2 coefficient = -5.83904e-15
    order 3 coefficient = -3.60652e-19
done.
AO calibration for channel 0, range 0 .
set ao to 6554, measured -8.08187 .
set ao to 58982, measured 8.08028 .
Polynomial:
    order = 1
    expansion origin = 0
    order 0 coefficient = 32770.6
    order 1 coefficient = 3243.88
AO calibration for channel 0, range 1 .
set ao to 6554, measured -4.04143 .
set ao to 58982, measured 4.04084 .
Polynomial:
    order = 1
    expansion origin = 0
    order 0 coefficient = 32769.9
    order 1 coefficient = 6486.79
AO calibration for channel 1, range 0 .
set ao to 6554, measured -8.08201 .
set ao to 58982, measured 8.08046 .
Polynomial:
    order = 1
    expansion origin = 0
    order 0 coefficient = 32770.5
    order 1 coefficient = 3243.81
AO calibration for channel 1, range 1 .
set ao to 6554, measured -4.0415 .
set ao to 58982, measured 4.04106 .
Polynomial:
    order = 1
    expansion origin = 0
    order 0 coefficient = 32769.4
    order 1 coefficient = 6486.56

failed to open file /var/lib/libcomedi0/lib/comedi/calibrations/ni_pcimio_pci-6251_comedi0 for writing
fopen: No such file or directory
Caught exception: writeCalibrationSet: write_calibration_file() failed.

I don't see libcomedi0 under /var/lib. It seems that everything is fine until it tries to write the calibration. Anyone have any idea on what is going on?

All help/advice is appreciated!

Yogi

