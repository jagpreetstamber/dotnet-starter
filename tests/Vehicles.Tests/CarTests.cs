// <copyright file="CarTests.cs" company="MyCompany">
// Copyright (c) MyCompany. All rights reserved.
// </copyright>

namespace Vehicles.Tests;

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

/// <summary>
/// Defines the <see cref="CarTests" />.
/// </summary>
[TestClass]
public class CarTests
{
    /// <summary>
    /// Test starting the car.
    /// </summary>
    [TestMethod]
    public void CarShouldStartWithoutError()
    {
        var car = new Car();
        car.Start();
    }

    /// <summary>
    /// Test driving the car without starting.
    /// </summary>
    [TestMethod]
    [ExpectedException(typeof(InvalidOperationException))]
    public void CarShouldNotDriveWithoutStarting()
    {
        var car = new Car();
        car.Drive();
    }

    /// <summary>
    /// Test driving the car.
    /// </summary>
    [TestMethod]
    public void CarShouldDriveAfterStarting()
    {
        var car = new Car();
        car.Start();
        car.Drive();
    }
}